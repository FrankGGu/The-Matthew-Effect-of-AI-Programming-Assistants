type TrieNode struct {
	children [2]*TrieNode
	count    int // Number of values passing through this node
}

type Trie struct {
	root    *TrieNode
	maxBits int // Maximum number of bits for values
}

func newTrie(maxBits int) *Trie {
	return &Trie{root: &TrieNode{}, maxBits: maxBits}
}

func (t *Trie) Insert(val int) {
	curr := t.root
	for i := t.maxBits - 1; i >= 0; i-- {
		bit := (val >> i) & 1
		if curr.children[bit] == nil {
			curr.children[bit] = &TrieNode{}
		}
		curr = curr.children[bit]
		curr.count++
	}
}

func (t *Trie) Remove(val int) {
	curr := t.root
	for i := t.maxBits - 1; i >= 0; i-- {
		bit := (val >> i) & 1
		curr = curr.children[bit]
		curr.count--
	}
}

func (t *Trie) QueryMaxXor(target, maxVal int) int {
	curr := t.root
	currentXorSum := 0

	for i := t.maxBits - 1; i >= 0; i-- {
		if curr == nil || curr.count == 0 {
			return -1
		}

		targetBit := (target >> i) & 1
		maxValBit := (maxVal >> i) & 1

		canPickOpposite := (curr.children[1-targetBit] != nil && curr.children[1-targetBit].count > 0) && (1-targetBit <= maxValBit)
		canPickSame := (curr.children[targetBit] != nil && curr.children[targetBit].count > 0) && (targetBit <= maxValBit)

		var chosenBit int
		if canPickOpposite {
			if (1-targetBit) < maxValBit {
				currentXorSum |= (1 << i)
				return currentXorSum | t.greedyMaxXor(curr.children[1-targetBit], target, i-1)
			}
			chosenBit = 1 - targetBit
			currentXorSum |= (1 << i)
		} else if canPickSame {
			if targetBit < maxValBit {
				return currentXorSum | t.greedyMaxXor(curr.children[targetBit], target, i-1)
			}
			chosenBit = targetBit
		} else {
			return -1
		}
		curr = curr.children[chosenBit]
	}
	return currentXorSum
}

func (t *Trie) greedyMaxXor(node *TrieNode, target, bitIdx int) int {
	if node == nil || node.count == 0 || bitIdx < 0 {
		return 0
	}
	res := 0
	targetBit := (target >> bitIdx) & 1

	if node.children[1-targetBit] != nil && node.children[1-targetBit].count > 0 {
		res |= (1 << bitIdx)
		res |= t.greedyMaxXor(node.children[1-targetBit], target, bitIdx-1)
	} else if node.children[targetBit] != nil && node.children[targetBit].count > 0 {
		res |= t.greedyMaxXor(node.children[targetBit], target, bitIdx-1)
	}
	return res
}

type query struct {
	maxVal   int
	queryIdx int
}

func maxGeneticDifference(parents []int, nums []int, queries [][]int) []int {
	n := len(parents)
	adj := make([][]int, n)
	for i := 1; i < n; i++ {
		adj[parents[i]] = append(adj[parents[i]], i)
	}

	ans := make([]int, len(queries))
	queriesForNode := make([][]query, n)
	for i, q := range queries {
		node, maxVal := q[0], q[1]
		queriesForNode[node] = append(queriesForNode[node], query{maxVal: maxVal, queryIdx: i})
	}

	trie := newTrie(18) // Max value 2*10^5, so 18 bits (0 to 17) are sufficient

	var dfs func(u int)
	dfs = func(u int) {
		trie.Insert(nums[u])

		for _, q := range queriesForNode[u] {
			res := trie.QueryMaxXor(nums[u], q.maxVal)
			if res == -1 {
				ans[q.queryIdx] = 0 // If no valid number found, difference is 0
			} else {
				ans[q.queryIdx] = res
			}
		}

		for _, v := range adj[u] {
			dfs(v)
		}

		trie.Remove(nums[u])
	}

	dfs(0)
	return ans
}