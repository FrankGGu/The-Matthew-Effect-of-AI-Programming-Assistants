import (
	"strconv"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func findDuplicateSubtrees(root *TreeNode) []*TreeNode {
	res := []*TreeNode{}
	subtrees := make(map[string]int)
	var traverse func(node *TreeNode) string

	traverse = func(node *TreeNode) string {
		if node == nil {
			return "#"
		}

		left := traverse(node.Left)
		right := traverse(node.Right)

		subtree := strconv.Itoa(node.Val) + "," + left + "," + right

		if subtrees[subtree] == 1 {
			res = append(res, node)
		}

		subtrees[subtree]++
		return subtree
	}

	traverse(root)
	return res
}