func countPairs(nums []int, low int, high int) int {
	root := &TrieNode{}
	ans := 0
	for _, num := range nums {
		ans += count(root, num, high) - count(root, num, low-1)
		insert(root, num)
	}
	return ans
}

type TrieNode struct {
	children [2]*TrieNode
	count    int
}

func insert(root *TrieNode, num int) {
	curr := root
	for i := 15; i >= 0; i-- {
		bit := (num >> i) & 1
		if curr.children[bit] == nil {
			curr.children[bit] = &TrieNode{}
		}
		curr = curr.children[bit]
		curr.count++
	}
}

func count(root *TrieNode, num int, limit int) int {
	curr := root
	ans := 0
	for i := 15; i >= 0; i-- {
		if curr == nil {
			return 0
		}
		bit := (num >> i) & 1
		limitBit := (limit >> i) & 1
		if limitBit == 1 {
			if curr.children[bit] != nil {
				ans += curr.children[bit].count
			}
			curr = curr.children[1-bit]
		} else {
			curr = curr.children[bit]
		}
	}
	if curr != nil {
		ans += curr.count
	}
	return ans
}