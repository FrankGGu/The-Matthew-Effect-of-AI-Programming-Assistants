type TrieNode struct {
    children [2]*TrieNode
}

func findMaximumXOR(nums []int) int {
    root := &TrieNode{}
    maxXor := 0

    for _, num := range nums {
        node := root
        xorNode := root
        currentXor := 0

        for i := 31; i >= 0; i-- {
            bit := (num >> uint(i)) & 1

            if node.children[bit] == nil {
                node.children[bit] = &TrieNode{}
            }
            node = node.children[bit]

            toggledBit := 1 - bit
            if xorNode.children[toggledBit] != nil {
                currentXor += (1 << uint(i))
                xorNode = xorNode.children[toggledBit]
            } else {
                xorNode = xorNode.children[bit]
            }
        }

        if currentXor > maxXor {
            maxXor = currentXor
        }
    }

    return maxXor
}