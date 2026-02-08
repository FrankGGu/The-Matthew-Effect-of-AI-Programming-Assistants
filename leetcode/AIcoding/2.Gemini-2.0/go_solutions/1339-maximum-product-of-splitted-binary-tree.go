type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func maxProduct(root *TreeNode) int {
	totalSum := treeSum(root)
	maxProd := 0
	var dfs func(*TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}
		leftSum := dfs(node.Left)
		rightSum := dfs(node.Right)
		subtreeSum := leftSum + rightSum + node.Val
		prod1 := subtreeSum * (totalSum - subtreeSum)
		if prod1 > maxProd {
			maxProd = prod1
		}
		return subtreeSum
	}
	dfs(root)
	return maxProd % (1e9 + 7)
}

func treeSum(root *TreeNode) int {
	if root == nil {
		return 0
	}
	return root.Val + treeSum(root.Left) + treeSum(root.Right)
}