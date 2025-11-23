package main


func isSubStructure(A *TreeNode, B *TreeNode) bool {
	if A == nil || B == nil {
		return false
	}
	return check(A, B) || isSubStructure(A.Left, B) || isSubStructure(A.Right, B)
}

func check(A *TreeNode, B *TreeNode) bool {
	if B == nil {
		return true
	}
	if A == nil {
		return false
	}
	return A.Val == B.Val && check(A.Left, B.Left) && check(A.Right, B.Right)
}