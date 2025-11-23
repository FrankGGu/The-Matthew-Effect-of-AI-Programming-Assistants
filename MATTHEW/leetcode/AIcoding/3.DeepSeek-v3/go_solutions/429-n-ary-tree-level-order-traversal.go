/**
 * Definition for a Node.
 * type Node struct {
 *     Val int
 *     Children []*Node
 * }
 */

func levelOrder(root *Node) [][]int {
    if root == nil {
        return [][]int{}
    }

    var result [][]int
    queue := []*Node{root}

    for len(queue) > 0 {
        levelSize := len(queue)
        var currentLevel []int

        for i := 0; i < levelSize; i++ {
            node := queue[0]
            queue = queue[1:]
            currentLevel = append(currentLevel, node.Val)

            for _, child := range node.Children {
                queue = append(queue, child)
            }
        }

        result = append(result, currentLevel)
    }

    return result
}