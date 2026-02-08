/**
 * Definition for a Node.
 * type Node struct {
 *     Val int
 *     Children []*Node
 * }
 */

func maxDepth(root *Node) int {
    if root == nil {
        return 0
    }
    max := 0
    for _, child := range root.Children {
        depth := maxDepth(child)
        if depth > max {
            max = depth
        }
    }
    return max + 1
}