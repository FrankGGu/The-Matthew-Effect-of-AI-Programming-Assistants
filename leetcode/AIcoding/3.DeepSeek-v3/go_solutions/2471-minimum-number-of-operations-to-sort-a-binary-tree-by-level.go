/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func minimumOperations(root *TreeNode) int {
    if root == nil {
        return 0
    }

    queue := []*TreeNode{root}
    operations := 0

    for len(queue) > 0 {
        levelSize := len(queue)
        level := make([]int, 0, levelSize)

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            level = append(level, node.Val)

            if node.Left != nil {
                queue = append(queue, node.Left)
            }
            if node.Right != nil {
                queue = append(queue, node.Right)
            }
        }

        sortedLevel := make([]int, len(level))
        copy(sortedLevel, level)
        sort.Ints(sortedLevel)

        pos := make(map[int]int)
        for i, num := range sortedLevel {
            pos[num] = i
        }

        visited := make([]bool, len(level))
        for i := 0; i < len(level); i++ {
            if !visited[i] {
                j := i
                cycleSize := 0
                for !visited[j] {
                    visited[j] = true
                    j = pos[level[j]]
                    cycleSize++
                }
                if cycleSize > 0 {
                    operations += cycleSize - 1
                }
            }
        }
    }

    return operations
}