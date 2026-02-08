/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func printTree(root *TreeNode) [][]string {
    if root == nil {
        return [][]string{}
    }

    height := getHeight(root)
    width := (1 << height) - 1
    res := make([][]string, height)

    for i := range res {
        res[i] = make([]string, width)
    }

    fill(res, root, 0, 0, width-1)
    return res
}

func fill(res [][]string, node *TreeNode, row, left, right int) {
    if node == nil {
        return
    }

    mid := left + (right-left)/2
    res[row][mid] = strconv.Itoa(node.Val)

    fill(res, node.Left, row+1, left, mid-1)
    fill(res, node.Right, row+1, mid+1, right)
}

func getHeight(node *TreeNode) int {
    if node == nil {
        return 0
    }
    return 1 + max(getHeight(node.Left), getHeight(node.Right))
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}