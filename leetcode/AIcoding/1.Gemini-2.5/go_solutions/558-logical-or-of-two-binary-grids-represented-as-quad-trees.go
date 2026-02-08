func intersect(quadTree1 *Node, quadTree2 *Node) *Node {
	if quadTree1.IsLeaf {
		if quadTree1.Val {
			return quadTree1
		}
		return quadTree2
	}

	if quadTree2.IsLeaf {
		if quadTree2.Val {
			return quadTree2
		}
		return quadTree1
	}

	topLeft := intersect(quadTree1.TopLeft, quadTree2.TopLeft)
	topRight := intersect(quadTree1.TopRight, quadTree2.TopRight)
	bottomLeft := intersect(quadTree1.BottomLeft, quadTree2.BottomLeft)
	bottomRight := intersect(quadTree1.BottomRight, quadTree2.BottomRight)

	if topLeft.IsLeaf && topRight.IsLeaf && bottomLeft.IsLeaf && bottomRight.IsLeaf {
		if topLeft.Val == topRight.Val && topRight.Val == bottomLeft.Val && bottomLeft.Val == bottomRight.Val {
			return &Node{Val: topLeft.Val, IsLeaf: true}
		}
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