type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func createBinaryTree(descriptions [][]int) *TreeNode {
    nodes := make(map[int]*TreeNode)
    childSet := make(map[int]struct{})

    for _, desc := range descriptions {
        parentVal, childVal, isLeft := desc[0], desc[1], desc[2] == 1
        if _, ok := nodes[parentVal]; !ok {
            nodes[parentVal] = &TreeNode{Val: parentVal}
        }
        if _, ok := nodes[childVal]; !ok {
            nodes[childVal] = &TreeNode{Val: childVal}
        }
        if isLeft {
            nodes[parentVal].Left = nodes[childVal]
        } else {
            nodes[parentVal].Right = nodes[childVal]
        }
        childSet[childVal] = struct{}{}
    }

    for _, desc := range descriptions {
        if _, ok := childSet[desc[0]]; !ok {
            return nodes[desc[0]]
        }
    }

    return nil
}