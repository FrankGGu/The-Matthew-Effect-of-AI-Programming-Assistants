import (
	"sort"
)

func maximizeXor(nums []int, queries [][]int) []int {
	sort.Ints(nums)
	n := len(nums)
	m := len(queries)
	res := make([]int, m)
	for i := range queries {
		res[i] = -1
	}

	type queryWithIndex struct {
		index int
		query []int
	}

	queriesWithIndex := make([]queryWithIndex, m)
	for i := range queries {
		queriesWithIndex[i] = queryWithIndex{index: i, query: queries[i]}
	}

	sort.Slice(queriesWithIndex, func(i, j int) bool {
		return queriesWithIndex[i].query[1] < queriesWithIndex[j].query[1]
	})

	trie := newTrie()
	idx := 0
	for _, q := range queriesWithIndex {
		for idx < n && nums[idx] <= q.query[1] {
			trie.insert(nums[idx])
			idx++
		}
		if idx > 0 {
			res[q.index] = trie.maxXor(q.query[0])
		}
	}

	return res
}

type trieNode struct {
	children [2]*trieNode
}

type trie struct {
	root *trieNode
}

func newTrie() *trie {
	return &trie{root: &trieNode{}}
}

func (t *trie) insert(num int) {
	curr := t.root
	for i := 31; i >= 0; i-- {
		bit := (num >> i) & 1
		if curr.children[bit] == nil {
			curr.children[bit] = &trieNode{}
		}
		curr = curr.children[bit]
	}
}

func (t *trie) maxXor(num int) int {
	curr := t.root
	xor := 0
	for i := 31; i >= 0; i-- {
		bit := (num >> i) & 1
		if curr.children[1-bit] != nil {
			xor |= (1 << i)
			curr = curr.children[1-bit]
		} else {
			curr = curr.children[bit]
		}
	}
	return xor
}