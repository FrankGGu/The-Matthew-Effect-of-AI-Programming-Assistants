import "fmt"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func decorateTree(root *TreeNode, decorationValues []int) *TreeNode {
	index := 0
	var dfs func(node *TreeNode)
	dfs = func(node *TreeNode) {
		if node == nil {
			return
		}
		dfs(node.Left)
		node.Val = decorationValues[index]
		index++
		dfs(node.Right)
	}

	dfs(root)
	return root
}