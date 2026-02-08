func longestZigZag(root *TreeNode) int {
    maxLen := 0

    // dfs performs a depth-first search to find zigzag paths.