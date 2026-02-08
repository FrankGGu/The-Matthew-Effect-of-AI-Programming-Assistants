/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func closestNodes(root *TreeNode, queries []int) [][]int {
    arr := []int{}
    var inorder func(*TreeNode)
    inorder = func(node *TreeNode) {
        if node == nil {
            return
        }
        inorder(node.Left)
        arr = append(arr, node.Val)
        inorder(node.Right)
    }
    inorder(root)

    res := make([][]int, len(queries))
    for i, q := range queries {
        min, max := -1, -1
        left, right := 0, len(arr)-1
        for left <= right {
            mid := left + (right-left)/2
            if arr[mid] == q {
                min, max = q, q
                break
            } else if arr[mid] < q {
                min = arr[mid]
                left = mid + 1
            } else {
                max = arr[mid]
                right = mid - 1
            }
        }
        res[i] = []int{min, max}
    }
    return res
}