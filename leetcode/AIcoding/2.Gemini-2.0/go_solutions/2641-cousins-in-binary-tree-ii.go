func replaceValueInTree(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }

    root.Val = 0

    q := []*TreeNode{root}

    for len(q) > 0 {
        levelSize := len(q)
        levelSum := 0
        nextLevel := []*TreeNode{}

        for i := 0; i < levelSize; i++ {
            node := q[i]
            if node.Left != nil {
                levelSum += node.Left.Val
                nextLevel = append(nextLevel, node.Left)
            }
            if node.Right != nil {
                levelSum += node.Right.Val
                nextLevel = append(nextLevel, node.Right)
            }
        }

        for i := 0; i < levelSize; i++ {
            node := q[i]
            sum := 0
            if node.Left != nil {
                sum += node.Left.Val
            }
            if node.Right != nil {
                sum += node.Right.Val
            }

            if node.Left != nil {
                node.Left.Val = levelSum - sum
            }
            if node.Right != nil {
                node.Right.Val = levelSum - sum
            }
        }
        q = nextLevel
    }

    return root
}