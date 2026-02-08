import "math"

var maxSum int

func maxSumBST(root *TreeNode) int {
	maxSum = 0 // Reset for each test case on LeetCode
	dfs(root)
	return maxSum
}

func dfs(root *TreeNode) (bool, int, int, int) {
	if root == nil {
		// A nil tree is a valid BST with sum 0.
		// minVal is MaxInt32 to ensure any parent's root.Val > leftMax is true.
		// maxVal is MinInt32 to ensure any parent's root.Val < rightMin is true.
		return true, math.MaxInt32, math.MinInt32, 0
	}

	leftIsBST, leftMin, leftMax, leftSum := dfs(root.Left)
	rightIsBST, rightMin, rightMax, rightSum := dfs(root.Right)

	// Check if the current subtree rooted at `root` is a BST
	if leftIsBST && rightIsBST && root.Val > leftMax && root.Val < rightMin {
		currentSum := leftSum + rightSum + root.Val
		maxSum = max(maxSum, currentSum)

		currentMin := min(leftMin, root.Val)
		currentMax := max(rightMax, root.Val)

		return true, currentMin, currentMax, currentSum
	} else {
		// If the current subtree is not a BST, its min/max/sum values
		// are irrelevant for forming a larger BST.
		// We return false for isBST. The other values can be arbitrary
		// as they will not be used by the parent if isBST is false.
		return false, 0, 0, 0
	}
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}