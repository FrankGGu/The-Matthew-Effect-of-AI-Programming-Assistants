func countPaths(root *TreeNode, target int) int {
    count := 0
    prefix := make(map[int]int)
    prefix[0] = 1

    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, currentXOR int) {
        if node == nil {
            return
        }
        currentXOR ^= node.Val
        count += prefix[currentXOR ^ target]
        prefix[currentXOR]++
        dfs(node.Left, currentXOR)
        dfs(node.Right, currentXOR)
        prefix[currentXOR]--
    }

    dfs(root, 0)
    return count
}