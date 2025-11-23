package main

func longestIncreasingPath(root *TreeNode) int {
    if root == nil {
        return 0
    }
    memo := make(map[*TreeNode]int)
    directions := [][]int{{0, 1}, {1, 0}, {0, -1}, {-1, 0}}
    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if val, ok := memo[node]; ok {
            return val
        }
        maxPath := 1
        for _, dir := range directions {
            x, y := node.Val+dir[0], node.Val+dir[1]
            if child := findNode(root, x, y); child != nil && child.Val > node.Val {
                currentPath := 1 + dfs(child)
                if currentPath > maxPath {
                    maxPath = currentPath
                }
            }
        }
        memo[node] = maxPath
        return maxPath
    }
    result := 0
    queue := []*TreeNode{root}
    visited := make(map[*TreeNode]bool)
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        if visited[node] {
            continue
        }
        visited[node] = true
        result = max(result, dfs(node))
        for _, dir := range directions {
            x, y := node.Val+dir[0], node.Val+dir[1]
            if child := findNode(root, x, y); child != nil {
                queue = append(queue, child)
            }
        }
    }
    return result
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func findNode(root *TreeNode, x, y int) *TreeNode {
    if root == nil {
        return nil
    }
    if root.Val == x {
        if y == 0 {
            return root
        }
        if root.Left != nil && root.Left.Val == y {
            return root.Left
        }
        if root.Right != nil && root.Right.Val == y {
            return root.Right
        }
    }
    left := findNode(root.Left, x, y)
    if left != nil {
        return left
    }
    return findNode(root.Right, x, y)
}