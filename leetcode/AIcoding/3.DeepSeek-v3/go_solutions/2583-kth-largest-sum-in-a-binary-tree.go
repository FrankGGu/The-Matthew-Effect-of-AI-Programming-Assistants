/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func kthLargestLevelSum(root *TreeNode, k int) int64 {
    if root == nil {
        return -1
    }

    queue := []*TreeNode{root}
    var sums []int64

    for len(queue) > 0 {
        levelSize := len(queue)
        var levelSum int64 = 0
        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            levelSum += int64(node.Val)
            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }
        sums = append(sums, levelSum)
    }

    if k > len(sums) {
        return -1
    }

    sort.Slice(sums, func(i, j int) bool {
        return sums[i] > sums[j]
    })

    return sums[k-1]
}