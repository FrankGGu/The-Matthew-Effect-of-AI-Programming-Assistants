package main

func longestPathWithDifferentAdjacentCharacters(root *TreeNode) int {
    var maxLen int
    var dfs func(*TreeNode, byte) int
    dfs = func(node *TreeNode, parentChar byte) int {
        if node == nil {
            return 0
        }
        currentChar := node.Val
        if currentChar == parentChar {
            return 0
        }
        left := dfs(node.Left, currentChar)
        right := dfs(node.Right, currentChar)
        maxLen = max(maxLen, left+right+1)
        return max(left, right) + 1
    }
    dfs(root, 0)
    return maxLen
}

type TreeNode struct {
    Val   byte
    Left  *TreeNode
    Right *TreeNode
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}