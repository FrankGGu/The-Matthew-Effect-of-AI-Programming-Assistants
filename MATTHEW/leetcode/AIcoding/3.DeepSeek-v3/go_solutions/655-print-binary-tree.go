/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func printTree(root *TreeNode) [][]string {
    height := getHeight(root)
    width := (1 << height) - 1
    res := make([][]string, height)
    for i := range res {
        res[i] = make([]string, width)
    }
    fill(root, &res, 0, 0, width-1)
    return res
}

func getHeight(root *TreeNode) int {
    if root == nil {
        return 0
    }
    left := getHeight(root.Left)
    right := getHeight(root.Right)
    if left > right {
        return left + 1
    }
    return right + 1
}

func fill(root *TreeNode, res *[][]string, row, left, right int) {
    if root == nil {
        return
    }
    mid := (left + right) / 2
    (*res)[row][mid] = strconv.Itoa(root.Val)
    fill(root.Left, res, row+1, left, mid-1)
    fill(root.Right, res, row+1, mid+1, right)
}