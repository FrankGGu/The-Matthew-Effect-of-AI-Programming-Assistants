/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func levelOrderBottom(root *TreeNode) [][]int {
    if root == nil {
        return [][]int{}
    }

    var result [][]int
    queue := []*TreeNode{root}

    for len(queue) > 0 {
        level := []int{}
        nextQueue := []*TreeNode{}

        for _, node := range queue {
            level = append(level, node.Val)
            if node.Left != nil {
                nextQueue = append(nextQueue, node.Left)
            }
            if node.Right != nil {
                nextQueue = append(nextQueue, node.Right)
            }
        }

        result = append([][]int{level}, result...)
        queue = nextQueue
    }

    return result
}