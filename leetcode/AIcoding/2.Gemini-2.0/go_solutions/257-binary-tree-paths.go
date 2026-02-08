func binaryTreePaths(root *TreeNode) []string {
    if root == nil {
        return []string{}
    }

    var paths []string
    var dfs func(*TreeNode, string)

    dfs = func(node *TreeNode, path string) {
        if node.Left == nil && node.Right == nil {
            paths = append(paths, path+strconv.Itoa(node.Val))
            return
        }

        path += strconv.Itoa(node.Val) + "->"

        if node.Left != nil {
            dfs(node.Left, path)
        }
        if node.Right != nil {
            dfs(node.Right, path)
        }
    }

    dfs(root, "")
    return paths
}

import "strconv"