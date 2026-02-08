func or(q1 *Node, q2 *Node) *Node {
	if q1 == nil {
		return q2
	}
	if q2 == nil {
		return q1
	}

	if q1.IsLeaf {
		if q1.Val {
			return &Node{Val: true, IsLeaf: true}
		} else {
			return q2
		}
	}

	if q2.IsLeaf {
		if q2.Val {
			return &Node{Val: true, IsLeaf: true}
		} else {
			return q1
		}
	}

	topLeft := or(q1.TopLeft, q2.TopLeft)
	topRight := or(q1.TopRight, q2.TopRight)
	bottomLeft := or(q1.BottomLeft, q2.BottomLeft)
	bottomRight := or(q1.BottomRight, q2.BottomRight)

	if topLeft.IsLeaf && topRight.IsLeaf && bottomLeft.IsLeaf && bottomRight.IsLeaf &&
		topLeft.Val == topRight.Val && topRight.Val == bottomLeft.Val && bottomLeft.Val == bottomRight.Val {
		return &Node{Val: topLeft.Val, IsLeaf: true}
	}

	return &Node{
		Val:       false,
		IsLeaf:    false,
		TopLeft:   topLeft,
		TopRight:  topRight,
		BottomLeft: bottomLeft,
		BottomRight: bottomRight,
	}
}