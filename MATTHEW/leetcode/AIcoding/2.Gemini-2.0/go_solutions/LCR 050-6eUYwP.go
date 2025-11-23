type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func pathSum(root *TreeNode, targetSum int) int {
	if root == nil {
		return 0
	}
	count := 0
	var dfs func(*TreeNode, int)
	dfs = func(node *TreeNode, sum int) {
		if node == nil {
			return
		}
		if node.Val == sum {
			count++
		}
		dfs(node.Left, sum-node.Val)
		dfs(node.Right, sum-node.Val)
	}

	dfs(root, targetSum)
	count += pathSum(root.Left, targetSum)
	count += pathSum(root.Right, targetSum)

	return count
}