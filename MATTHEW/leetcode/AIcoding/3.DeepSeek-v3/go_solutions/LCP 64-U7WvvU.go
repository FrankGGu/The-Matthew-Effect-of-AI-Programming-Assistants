/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func closeLampInTree(root *TreeNode) int {
    var dfs func(*TreeNode) (int, int, int, int)
    dfs = func(node *TreeNode) (a, b, c, d int) {
        if node == nil {
            return 0, 0, 0, 0
        }
        la, lb, lc, ld := dfs(node.Left)
        ra, rb, rc, rd := dfs(node.Right)

        if node.Val == 1 {
            a = min(la+ra, lb+rb+1, lc+rc+1, ld+rd+2)
            b = min(la+ra+1, lb+rb, lc+rc+2, ld+rd+1)
            c = min(la+ra+1, lb+rb+2, lc+rc, ld+rd+1)
            d = min(la+ra+2, lb+rb+1, lc+rc+1, ld+rd)
        } else {
            a = min(la+ra+1, lb+rb, lc+rc, ld+rd+1)
            b = min(la+ra, lb+rb+1, lc+rc+1, ld+rd+2)
            c = min(la+ra, lb+rb+1, lc+rc+2, ld+rd+1)
            d = min(la+ra+1, lb+rb, lc+rc+1, ld+rd)
        }
        return
    }
    a, _, _, _ := dfs(root)
    return a
}

func min(nums ...int) int {
    res := nums[0]
    for _, num := range nums {
        if num < res {
            res = num
        }
    }
    return res
}