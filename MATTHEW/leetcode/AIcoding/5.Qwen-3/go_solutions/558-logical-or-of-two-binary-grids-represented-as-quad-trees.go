package main


type Node struct {
	Val    bool
	IsLeaf bool
	TopLeft  *Node
	TopRight *Node
	BottomLeft *Node
	BottomRight *Node
}

func intersect(quadTree1 *Node, quadTree2 *Node) *Node {
	if quadTree1.IsLeaf {
		return quadTree1.Val ? quadTree1 : quadTree2
	}
	if quadTree2.IsLeaf {
		return quadTree2.Val ? quadTree2 : quadTree1
	}
	quadTree1.TopLeft = intersect(quadTree1.TopLeft, quadTree2.TopLeft)
	quadTree1.TopRight = intersect(quadTree1.TopRight, quadTree2.TopRight)
	quadTree1.BottomLeft = intersect(quadTree1.BottomLeft, quadTree2.BottomLeft)
	quadTree1.BottomRight = intersect(quadTree1.BottomRight, quadTree2.BottomRight)
	if quadTree1.TopLeft.IsLeaf && quadTree1.TopRight.IsLeaf && quadTree1.BottomLeft.IsLeaf && quadTree1.BottomRight.IsLeaf &&
		quadTree1.TopLeft.Val == quadTree1.TopRight.Val && quadTree1.TopRight.Val == quadTree1.BottomLeft.Val && quadTree1.BottomLeft.Val == quadTree1.BottomRight.Val {
		return &Node{Val: quadTree1.TopLeft.Val, IsLeaf: true}
	}
	return quadTree1
}