/**
 * Definition for a Node.
 * type Node struct {
 *     Val int
 *     Children []*Node
 * }
 */

func postorder(root *Node) []int {
    var result []int
    if root == nil {
        return result
    }
    stack := []*Node{root}
    for len(stack) > 0 {
        node := stack[len(stack)-1]
        stack = stack[:len(stack)-1]
        result = append([]int{node.Val}, result...)
        for _, child := range node.Children {
            stack = append(stack, child)
        }
    }
    return result
}