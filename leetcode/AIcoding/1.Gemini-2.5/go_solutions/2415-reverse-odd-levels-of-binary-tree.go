func reverseOddLevels(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }

    q := []*TreeNode{root}
    level := 0

    for len(q) > 0 {
        n := len(q)
        currentLevelNodes := make([]*TreeNode, n)

        for i := 0; i < n; i++ {
            node := q[0]
            q = q[1:]
            currentLevelNodes[i] = node

            if node.Left != nil {
                q = append(q, node.Left)
            }
            if node.Right != nil {
                q = append(q, node.Right)
            }
        }

        if level%2 == 1 { 
            for i := 0; i < n/2; i++ {
                currentLevelNodes[i].Val, currentLevelNodes[n-1-i].Val = currentLevelNodes[n-1-i].Val, currentLevelNodes[i].Val
            }
        }
        level++
    }

    return root
}