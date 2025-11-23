/**
 * Definition for a QuadTree node.
 * type Node struct {
 *     Val bool
 *     IsLeaf bool
 *     TopLeft *Node
 *     TopRight *Node
 *     BottomLeft *Node
 *     BottomRight *Node
 * }
 */

func construct(grid [][]int) *Node {
    var build func(x, y, size int) *Node
    build = func(x, y, size int) *Node {
        if size == 1 {
            return &Node{
                Val: grid[x][y] == 1,
                IsLeaf: true,
            }
        }
        half := size / 2
        topLeft := build(x, y, half)
        topRight := build(x, y + half, half)
        bottomLeft := build(x + half, y, half)
        bottomRight := build(x + half, y + half, half)

        if topLeft.IsLeaf && topRight.IsLeaf && bottomLeft.IsLeaf && bottomRight.IsLeaf &&
           topLeft.Val == topRight.Val && topRight.Val == bottomLeft.Val && bottomLeft.Val == bottomRight.Val {
            return &Node{
                Val: topLeft.Val,
                IsLeaf: true,
            }
        }
        return &Node{
            Val: false,
            IsLeaf: false,
            TopLeft: topLeft,
            TopRight: topRight,
            BottomLeft: bottomLeft,
            BottomRight: bottomRight,
        }
    }
    return build(0, 0, len(grid))
}