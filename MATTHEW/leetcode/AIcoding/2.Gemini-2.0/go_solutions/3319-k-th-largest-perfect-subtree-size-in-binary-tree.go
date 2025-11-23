import (
	"sort"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func kthLargestPerfectSubtreeSize(root *TreeNode, k int) int {
	sizes := []int{}
	var dfs func(*TreeNode) int
	dfs = func(node *TreeNode) int {
		if node == nil {
			return 0
		}

		leftSize := dfs(node.Left)
		rightSize := dfs(node.Right)

		if leftSize == rightSize {
			size := 1 + leftSize + rightSize
			sizes = append(sizes, size)
			return size
		}

		return 0
	}

	dfs(root)

	sort.Sort(sort.Reverse(sort.IntSlice(sizes)))

	if k > len(sizes) {
		return -1
	}

	return sizes[k-1]
}