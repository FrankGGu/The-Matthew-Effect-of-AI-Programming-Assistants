import "strconv"

var counts map[string]int
var result []*TreeNode

func findDuplicateSubtrees(root *TreeNode) []*TreeNode {
    counts = make(map[string]int)
    result = make([]*TreeNode, 0)

    serialize(root)

    return result
}

func serialize(node *TreeNode) string {
    if node == nil {
        return "#"
    }

    left := serialize(node.Left)
    right := serialize(node.Right)

    s := strconv.Itoa(node.Val) + "," + left + "," + right

    counts[s]++
    if counts[s] == 2 {
        result = append(result, node)
    }

    return s
}