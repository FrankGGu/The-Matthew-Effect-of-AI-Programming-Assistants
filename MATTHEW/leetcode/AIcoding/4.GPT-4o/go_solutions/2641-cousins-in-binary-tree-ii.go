/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func findCousins(root *TreeNode) [][]int {
    if root == nil {
        return nil
    }

    var result [][]int
    queue := []*TreeNode{root}

    for len(queue) > 0 {
        levelSize := len(queue)
        cousins := []int{}
        foundParent := false

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]

            if node.Left != nil {
                if foundParent {
                    cousins = append(cousins, node.Left.Val)
                } else {
                    queue = append(queue, node.Left)
                }
            }
            if node.Right != nil {
                if foundParent {
                    cousins = append(cousins, node.Right.Val)
                } else {
                    queue = append(queue, node.Right)
                }
            }

            if i == levelSize-1 {
                foundParent = true
            }
        }

        if len(cousins) > 0 {
            result = append(result, cousins)
        }
    }

    return result
}