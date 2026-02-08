package main


func findFrequentTreeSum(root *TreeNode) []int {
    sumCount := make(map[int]int)
    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        currentSum := left + right + node.Val
        sumCount[currentSum]++
        return currentSum
    }
    dfs(root)
    maxFreq := 0
    for _, v := range sumCount {
        if v > maxFreq {
            maxFreq = v
        }
    }
    result := []int{}
    for key, value := range sumCount {
        if value == maxFreq {
            result = append(result, key)
        }
    }
    return result
}