type Node struct {
	Val   bool
	IsLeaf bool
	TopLeft, TopRight, BottomLeft, BottomRight *Node
}

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

	tl := intersect(quadTree1.TopLeft, quadTree2.TopLeft)
	tr := intersect(quadTree1.TopRight, quadTree2.TopRight)
	bl := intersect(quadTree1.BottomLeft, quadTree2.BottomLeft)
	br := intersect(quadTree1.BottomRight, quadTree2.BottomRight)

	if tl.IsLeaf && tr.IsLeaf && bl.IsLeaf && br.IsLeaf && tl.Val == tr.Val && tl.Val == bl.Val && tl.Val == br.Val {
		return &Node{Val: tl.Val, IsLeaf: true}
	}

	return &Node{Val: false, IsLeaf: false, TopLeft: tl, TopRight: tr, BottomLeft: bl, BottomRight: br}
}