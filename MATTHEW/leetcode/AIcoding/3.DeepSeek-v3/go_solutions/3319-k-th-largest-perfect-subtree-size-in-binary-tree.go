/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

type SubtreeInfo struct {
    Size int
    IsPerfect bool
}

func kthLargestPerfectSubtreeSize(root *TreeNode, k int) int {
    var allSizes []int
    var dfs func(*TreeNode) SubtreeInfo
    dfs = func(node *TreeNode) SubtreeInfo {
        if node == nil {
            return SubtreeInfo{0, true}
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        size := 1 + left.Size + right.Size
        isPerfect := left.IsPerfect && right.IsPerfect && 
                      ((left.Size == 0 && right.Size == 0) || 
                       (left.Size > 0 && right.Size > 0 && left.Size == right.Size))
        if isPerfect {
            allSizes = append(allSizes, size)
        }
        return SubtreeInfo{size, isPerfect}
    }
    dfs(root)
    if len(allSizes) < k {
        return -1
    }
    sort.Sort(sort.Reverse(sort.IntSlice(allSizes)))
    return allSizes[k-1]
}