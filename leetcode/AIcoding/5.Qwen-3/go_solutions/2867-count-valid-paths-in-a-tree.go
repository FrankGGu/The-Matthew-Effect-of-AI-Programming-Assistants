package main

func countValidPaths(root *TreeNode) int {
    if root == nil {
        return 0
    }

    var dfs func(*TreeNode, map[int]bool) int
    dfs = func(node *TreeNode, visited map[int]bool) int {
        if node == nil {
            return 0
        }

        visited[node.Val] = true
        defer delete(visited, node.Val)

        count := 0
        if node.Left == nil && node.Right == nil {
            return 1
        }

        if node.Left != nil {
            count += dfs(node.Left, visited)
        }
        if node.Right != nil {
            count += dfs(node.Right, visited)
        }

        return count
    }

    var traverse func(*TreeNode)
    traverse = func(node *TreeNode) {
        if node == nil {
            return
        }

        visited := make(map[int]bool)
        dfs(node, visited)
        traverse(node.Left)
        traverse(node.Right)
    }

    traverse(root)
    return 0
}