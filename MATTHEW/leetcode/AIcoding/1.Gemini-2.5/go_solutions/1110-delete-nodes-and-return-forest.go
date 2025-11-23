func delNodes(root *TreeNode, to_delete []int) []*TreeNode {
    toDeleteSet := make(map[int]bool)
    for _, val := range to_delete {
        toDeleteSet[val] = true
    }

    var result []*TreeNode

    var dfs func(*TreeNode, bool) *TreeNode
    dfs = func(node *TreeNode, isRoot bool) *TreeNode {
        if node == nil {
            return nil
        }

        deleted := toDeleteSet[node.Val]

        if deleted {
            dfs(node.Left, true)
            dfs(node.Right, true)
            return nil
        } else {
            if isRoot {
                result = append(result, node)
            }
            node.Left = dfs(node.Left, false)
            node.Right = dfs(node.Right, false)
            return node
        }
    }

    dfs(root, true)

    return result
}