type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

var allPaths [][]int

func pathSum(root *TreeNode, targetSum int) [][]int {
	allPaths = [][]int{}
	if root == nil {
		return allPaths
	}

	currentPath := []int{}
	dfs(&currentPath, root, targetSum)

	return allPaths
}

func dfs(currentPath *[]int, node *TreeNode, remainingSum int) {
	if node == nil {
		return
	}

	// Add current node's value to the path
	*currentPath = append(*currentPath, node.Val)

	// Update remaining sum
	remainingSum -= node.Val

	// Check if it's a leaf node
	if node.Left == nil && node.Right == nil {
		if remainingSum == 0 {
			// Found a valid path, append a copy to allPaths
			pathCopy := make([]int, len(*currentPath))
			copy(pathCopy, *currentPath)
			allPaths = append(allPaths, pathCopy)
		}
	}

	// Recurse on children
	dfs(currentPath, node.Left, remainingSum)
	dfs(currentPath, node.Right, remainingSum)

	// Backtrack: remove the last element from the path
	*currentPath = (*currentPath)[:len(*currentPath)-1]
}