func delNodes(root *TreeNode, to_delete []int) []*TreeNode {
    toDeleteMap := make(map[int]bool)
    for _, val := range to_delete {
        toDeleteMap[val] = true
    }

    result := []*TreeNode{}

    var dfs func(*TreeNode, bool) *TreeNode
    dfs = func(node *TreeNode, isRoot bool) *TreeNode {
        if node == nil {
            return nil
        }

        deleted := toDeleteMap[node.Val]

        node.Left = dfs(node.Left, deleted)
        node.Right = dfs(node.Right, deleted)

        if deleted {
            return nil
        } else {
            if isRoot {
                result = append(result, node)
            }
            return node
        }
    }

    dfs(root, true)
    return result
}