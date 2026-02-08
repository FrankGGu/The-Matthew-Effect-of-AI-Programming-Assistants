/**
 * Definition for a QuadTree node.
 * type Node struct {
 *     Val   bool
 *     IsLeaf bool
 *     TopLeft *Node
 *     TopRight *Node
 *     BottomLeft *Node
 *     BottomRight *Node
 * }
 */

func construct(grid [][]int) *Node {
    return build(grid, 0, 0, len(grid), len(grid[0]))
}

func build(grid [][]int, x int, y int, width int, height int) *Node {
    if width == 1 && height == 1 {
        return &Node{Val: grid[x][y] == 1, IsLeaf: true}
    }

    midX, midY := x + width/2, y + height/2

    topLeft := build(grid, x, y, width/2, height/2)
    topRight := build(grid, x, midY, width/2, height/2)
    bottomLeft := build(grid, midX, y, width/2, height/2)
    bottomRight := build(grid, midX, midY, width/2, height/2)

    if topLeft.IsLeaf && topRight.IsLeaf && bottomLeft.IsLeaf && bottomRight.IsLeaf &&
       topLeft.Val == topRight.Val && topLeft.Val == bottomLeft.Val && topLeft.Val == bottomRight.Val {
        return &Node{Val: topLeft.Val, IsLeaf: true}
    }

    return &Node{IsLeaf: false, TopLeft: topLeft, TopRight: topRight, BottomLeft: bottomLeft, BottomRight: bottomRight}
}