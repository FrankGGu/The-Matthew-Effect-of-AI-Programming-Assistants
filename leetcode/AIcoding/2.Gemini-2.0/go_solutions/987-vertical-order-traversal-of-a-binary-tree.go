import "sort"

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func verticalTraversal(root *TreeNode) [][]int {
	nodes := []Node{}
	var traverse func(*TreeNode, int, int)
	traverse = func(node *TreeNode, col int, row int) {
		if node == nil {
			return
		}
		nodes = append(nodes, Node{col: col, row: row, val: node.Val})
		traverse(node.Left, col-1, row+1)
		traverse(node.Right, col+1, row+1)
	}
	traverse(root, 0, 0)

	sort.Slice(nodes, func(i, j int) bool {
		if nodes[i].col != nodes[j].col {
			return nodes[i].col < nodes[j].col
		}
		if nodes[i].row != nodes[j].row {
			return nodes[i].row < nodes[j].row
		}
		return nodes[i].val < nodes[j].val
	})

	result := [][]int{}
	if len(nodes) == 0 {
		return result
	}

	currentCol := nodes[0].col
	currentList := []int{nodes[0].val}
	for i := 1; i < len(nodes); i++ {
		if nodes[i].col == currentCol {
			currentList = append(currentList, nodes[i].val)
		} else {
			result = append(result, currentList)
			currentCol = nodes[i].col
			currentList = []int{nodes[i].val}
		}
	}
	result = append(result, currentList)

	return result
}

type Node struct {
	col int
	row int
	val int
}