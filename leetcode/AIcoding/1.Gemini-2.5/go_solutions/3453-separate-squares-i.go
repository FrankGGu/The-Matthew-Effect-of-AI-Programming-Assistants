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
	if n == 0 || len(grid[0]) == 0 {
		return nil
	}
	return buildQuadTree(grid, 0, 0, n)
}

func buildQuadTree(grid [][]int, r, c, size int) *Node {
	firstVal := grid[r][c]
	allSame := true
	for i := r; i < r+size; i++ {
		for j := c; j < c+size; j++ {
			if grid[i][j] != firstVal {
				allSame = false
				break
			}
		}
		if !allSame {
			break
		}
	}

	if allSame {
		return &Node{Val: firstVal == 1, IsLeaf: true}
	} else {
		halfSize := size / 2
		return &Node{
			Val:         false,
			IsLeaf:      false,
			TopLeft:     buildQuadTree(grid, r, c, halfSize),
			TopRight:    buildQuadTree(grid, r, c+halfSize, halfSize),
			BottomLeft:  buildQuadTree(grid, r+halfSize, c, halfSize),
			BottomRight: buildQuadTree(grid, r+halfSize, c+halfSize, halfSize),
		}
	}
}