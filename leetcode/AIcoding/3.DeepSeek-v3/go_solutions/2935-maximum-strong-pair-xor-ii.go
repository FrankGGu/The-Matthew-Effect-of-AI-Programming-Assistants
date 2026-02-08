type TrieNode struct {
    children [2]*TrieNode
}

func (root *TrieNode) insert(num int) {
    node := root
    for i := 31; i >= 0; i-- {
        bit := (num >> i) & 1
        if node.children[bit] == nil {
            node.children[bit] = &TrieNode{}
        }
        node = node.children[bit]
    }
}

func (root *TrieNode) findMaxXOR(num int) int {
    node := root
    maxXOR := 0
    for i := 31; i >= 0; i-- {
        bit := (num >> i) & 1
        toggleBit := 1 - bit
        if node.children[toggleBit] != nil {
            maxXOR |= (1 << i)
            node = node.children[toggleBit]
        } else {
            node = node.children[bit]
        }
    }
    return maxXOR
}

func maximumStrongPairXor(nums []int) int {
    sort.Ints(nums)
    root := &TrieNode{}
    maxXOR := 0
    left := 0
    for right := 0; right < len(nums); right++ {
        for nums[right] > 2*nums[left] {
            root.insert(nums[left])
            left++
        }
        if left <= right {
            currentMax := root.findMaxXOR(nums[right])
            if currentMax > maxXOR {
                maxXOR = currentMax
            }
        }
    }
    return maxXOR
}