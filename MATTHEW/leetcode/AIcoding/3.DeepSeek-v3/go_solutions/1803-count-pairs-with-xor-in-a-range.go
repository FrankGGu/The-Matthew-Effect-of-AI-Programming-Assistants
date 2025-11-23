type TrieNode struct {
    children [2]*TrieNode
    count int
}

func countPairs(nums []int, low int, high int) int {
    root := &TrieNode{}
    res := 0
    for _, num := range nums {
        res += query(root, num, high) - query(root, num, low-1)
        insert(root, num)
    }
    return res
}

func insert(root *TrieNode, num int) {
    node := root
    for i := 14; i >= 0; i-- {
        bit := (num >> i) & 1
        if node.children[bit] == nil {
            node.children[bit] = &TrieNode{}
        }
        node = node.children[bit]
        node.count++
    }
}

func query(root *TrieNode, num int, limit int) int {
    node := root
    res := 0
    for i := 14; i >= 0; i-- {
        if node == nil {
            return res
        }
        bit := (num >> i) & 1
        limitBit := (limit >> i) & 1
        if limitBit == 1 {
            if node.children[bit] != nil {
                res += node.children[bit].count
            }
            bit ^= 1
        }
        node = node.children[bit]
    }
    if node != nil {
        res += node.count
    }
    return res
}