import "fmt"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func smallestFromLeaf(root *TreeNode) string {
	var res string
	var dfs func(*TreeNode, string)
	dfs = func(node *TreeNode, s string) {
		if node == nil {
			return
		}
		s = string(rune(node.Val+'a')) + s
		if node.Left == nil && node.Right == nil {
			if res == "" || s < res {
				res = s
			}
			return
		}
		dfs(node.Left, s)
		dfs(node.Right, s)
	}
	dfs(root, "")
	return res
}