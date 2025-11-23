import "strconv"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func printTree(root *TreeNode) [][]string {
	height := getHeight(root)
	width := (1 << height) - 1
	res := make([][]string, height)
	for i := range res {
		res[i] = make([]string, width)
	}
	fill(res, root, 0, 0, width)
	return res
}

func getHeight(root *TreeNode) int {
	if root == nil {
		return 0
	}
	leftHeight := getHeight(root.Left)
	rightHeight := getHeight(root.Right)
	return max(leftHeight, rightHeight) + 1
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func fill(res [][]string, root *TreeNode, row, left, right int) {
	if root == nil {
		return
	}
	mid := (left + right) / 2
	res[row][mid] = strconv.Itoa(root.Val)
	fill(res, root.Left, row+1, left, mid-1)
	fill(res, root.Right, row+1, mid+1, right)
}