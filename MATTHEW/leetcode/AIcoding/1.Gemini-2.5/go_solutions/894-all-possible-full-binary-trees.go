func allPossibleFBT(n int) []*TreeNode {
    // Initialize memoization map
    memo := make(map[int][]*TreeNode)
    return findF