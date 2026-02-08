type Node struct {
	Val         bool
	IsLeaf      bool
	TopLeft     *Node
	TopRight    *Node
	BottomLeft  *Node
	BottomRight *Node
}

func construct(grid [][]int) *Node {
	n := len(grid)
	return buildTree(grid, 0, 0, n)
}

func buildTree(grid [][]int, row int, col int, size int) *Node {
	if size == 1 {
		return &Node{Val: grid[row][col], IsLeaf: true}
	}

	topLeft := buildTree(grid, row, col, size/2)
	topRight := buildTree(grid, row, col+size/2, size/2)
	bottomLeft := buildTree(grid, row+size/2, col, size/2)
	bottomRight := buildTree(grid, row+size/2, col+size/2, size/2)

	if topLeft.IsLeaf && topRight.IsLeaf && bottomLeft.IsLeaf && bottomRight.IsLeaf &&
		topLeft.Val == topRight.Val && topRight.Val == bottomLeft.Val && bottomLeft.Val == bottomRight.Val {
		return &Node{Val: topLeft.Val, IsLeaf: true}
	}

	return &Node{
		Val:         false,
		IsLeaf:      false,
		TopLeft:     topLeft,
		TopRight:    topRight,
		BottomLeft:  bottomLeft,
		BottomRight: bottomRight,
	}
}