import "fmt"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func treeQueries(root *TreeNode, queries []int) []int {
	depths := make(map[*TreeNode]int)
	maxHeights := make(map[int]int)
	var dfs func(*TreeNode, int) int
	dfs = func(node *TreeNode, depth int) int {
		if node == nil {
			return 0
		}
		depths[node] = depth
		leftHeight := dfs(node.Left, depth+1)
		rightHeight := dfs(node.Right, depth+1)
		return max(leftHeight, rightHeight) + 1
	}
	dfs(root, 0)

	var calculateMaxHeights func(*TreeNode, int)
	calculateMaxHeights = func(node *TreeNode, height int) {
		if node == nil {
			return
		}
		maxHeights[depths[node]] = max(maxHeights[depths[node]], height)
		calculateMaxHeights(node.Left, max(height, depths[node]+1+getHeight(node.Right, depths)))
		calculateMaxHeights(node.Right, max(height, depths[node]+1+getHeight(node.Left, depths)))
	}

	calculateMaxHeights(root, 0)

	result := make([]int, len(queries))
	for i, query := range queries {
		node := findNode(root, query)
		result[i] = maxHeights[depths[node]]
	}

	return result
}

func getHeight(node *TreeNode, depths map[*TreeNode]int) int {
	if node == nil {
		return 0
	}
	return depths[node] + 1 + max(getHeight(node.Left, depths), getHeight(node.Right, depths)) - (depths[node] + 1)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func findNode(root *TreeNode, val int) *TreeNode {
	if root == nil {
		return nil
	}
	if root.Val == val {
		return root
	}
	left := findNode(root.Left, val)
	if left != nil {
		return left
	}
	return findNode(root.Right, val)
}