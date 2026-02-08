package main


func pathSum(root *TreeNode, targetSum int) int {
    prefix := map[int]int{0: 1}
    var dfs func(node *TreeNode, currSum int) int
    dfs = func(node *TreeNode, currSum int) int {
        if node == nil {
            return 0
        }
        currSum += node.Val
        count := 0
        if v, ok := prefix[currSum-targetSum]; ok {
            count += v
        }
        prefix[currSum]++
        count += dfs(node.Left, currSum)
        count += dfs(node.Right, currSum)
        prefix[currSum]--
        return count
    }
    return dfs(root, 0)
}