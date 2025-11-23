func canMerge(trees []*TreeNode) *TreeNode {
    m := make(map[int]*TreeNode)
    degree := make(map[int]int)
    for _, tree := range trees {
        m[tree.Val] = tree
        degree[tree.Val] = 0
    }

    for _, tree := range trees {
        if tree.Left != nil {
            if _, ok := m[tree.Left.Val]; !ok {
                return nil
            }
            degree[tree.Left.Val]++
        }
        if tree.Right != nil {
            if _, ok := m[tree.Right.Val]; !ok {
                return nil
            }
            degree[tree.Right.Val]++
        }
    }

    roots := []*TreeNode{}
    for _, tree := range trees {
        if degree[tree.Val] == 0 {
            roots = append(roots, tree)
        }
    }

    if len(roots) != 1 {
        return nil
    }

    root := roots[0]
    delete(m, root.Val)

    var dfs func(node *TreeNode, minVal, maxVal int) bool
    dfs = func(node *TreeNode, minVal, maxVal int) bool {
        if node == nil {
            return true
        }
        if node.Val <= minVal || node.Val >= maxVal {
            return false
        }

        left := node.Left
        if left != nil {
            if _, ok := m[left.Val]; ok {
                node.Left = m[left.Val]
                delete(m, left.Val)
            }
        }

        right := node.Right
        if right != nil {
            if _, ok := m[right.Val]; ok {
                node.Right = m[right.Val]
                delete(m, right.Val)
            }
        }

        return dfs(node.Left, minVal, node.Val) && dfs(node.Right, node.Val, maxVal)
    }

    if !dfs(root, -1<<63, 1<<63-1) {
        return nil
    }

    if len(m) > 0 {
        return nil
    }

    return root
}