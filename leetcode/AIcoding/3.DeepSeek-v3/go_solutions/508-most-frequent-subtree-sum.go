/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func findFrequentTreeSum(root *TreeNode) []int {
    freq := make(map[int]int)
    maxFreq := 0

    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        sum := node.Val + dfs(node.Left) + dfs(node.Right)
        freq[sum]++
        if freq[sum] > maxFreq {
            maxFreq = freq[sum]
        }
        return sum
    }
    dfs(root)

    res := []int{}
    for sum, count := range freq {
        if count == maxFreq {
            res = append(res, sum)
        }
    }
    return res
}