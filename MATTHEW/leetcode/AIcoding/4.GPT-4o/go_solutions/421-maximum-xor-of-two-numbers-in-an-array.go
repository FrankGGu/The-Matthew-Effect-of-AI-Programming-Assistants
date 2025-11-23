func findMaximumXOR(nums []int) int {
    root := make(map[int]*TrieNode)
    maxNum := 0
    for _, num := range nums {
        maxNum = max(maxNum, num)
        insert(root, num)
    }
    maxXor := 0
    for _, num := range nums {
        maxXor = max(maxXor, query(root, num))
    }
    return maxXor
}

type TrieNode struct {
    children [2]*TrieNode
}

func insert(root *map[int]*TrieNode, num int) {
    node := &TrieNode{}
    for i := 31; i >= 0; i-- {
        bit := (num >> i) & 1
        if (*root)[bit] == nil {
            (*root)[bit] = &TrieNode{}
        }
        node = (*root)[bit]
    }
}

func query(root *map[int]*TrieNode, num int) int {
    node := *root
    maxXor := 0
    for i := 31; i >= 0; i-- {
        bit := (num >> i) & 1
        toggleBit := 1 - bit
        if node[toggleBit] != nil {
            maxXor |= (1 << i)
            node = node[toggleBit]
        } else {
            node = node[bit]
        }
    }
    return maxXor
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}