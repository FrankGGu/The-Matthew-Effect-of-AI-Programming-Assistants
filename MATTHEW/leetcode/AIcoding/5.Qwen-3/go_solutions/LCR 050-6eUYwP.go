package main


func pathSum(root *TreeNode, targetSum int) int {
    var count int
    prefix := map[int]int{0: 1}

    var dfs func(*TreeNode, int)
    dfs = func(node *TreeNode, currSum int) {
        if node == nil {
            return
        }
        currSum += node.Val
        if cnt, ok := prefix[currSum - targetSum]; ok {
            count += cnt
        }
        prefix[currSum]++
        dfs(node.Left, currSum)
        dfs(node.Right, currSum)
        prefix[currSum]--
    }

    dfs(root, 0)
    return count
}