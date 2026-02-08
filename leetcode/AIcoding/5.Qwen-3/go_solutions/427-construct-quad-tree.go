package main

type Node struct {
	Val    bool
	IsLeaf bool
	TopLeft  *Node
	TopRight *Node
	BottomLeft *Node
	BottomRight *Node
}

func construct(grid [][]int) *Node {
	var build func(int, int, int) *Node
	build = func(x, y, size int) *Node {
		if size == 1 {
			return &Node{Val: grid[x][y] == 1, IsLeaf: true}
		}
		left := build(x, y, size/2)
		right := build(x, y+size/2, size/2)
		bottomLeft := build(x+size/2, y, size/2)
		bottomRight := build(x+size/2, y+size/2, size/2)
		if left.IsLeaf && right.IsLeaf && bottomLeft.IsLeaf && bottomRight.IsLeaf && left.Val == right.Val && left.Val == bottomLeft.Val && left.Val == bottomRight.Val {
			return &Node{Val: left.Val, IsLeaf: true}
		}
		return &Node{Val: true, IsLeaf: false, TopLeft: left, TopRight: right, BottomLeft: bottomLeft, BottomRight: bottomRight}
	}
	return build(0, 0, len(grid))
}