import "math"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func widthOfBinaryTree(root *TreeNode) int {
	if root == nil {
		return 0
	}

	queue := []*TreeNode{root}
	width := 0
	levelMap := map[*TreeNode]int{root: 1}

	for len(queue) > 0 {
		levelSize := len(queue)
		min := math.MaxInt64
		max := math.MinInt64

		for i := 0; i < levelSize; i++ {
			node := queue[0]
			queue = queue[1:]

			pos := levelMap[node]

			if pos < min {
				min = pos
			}
			if pos > max {
				max = pos
			}

			if node.Left != nil {
				queue = append(queue, node.Left)
				levelMap[node.Left] = 2 * pos
			}
			if node.Right != nil {
				queue = append(queue, node.Right)
				levelMap[node.Right] = 2*pos + 1
			}
		}

		currentWidth := max - min + 1
		if currentWidth > width {
			width = currentWidth
		}
	}

	return width
}