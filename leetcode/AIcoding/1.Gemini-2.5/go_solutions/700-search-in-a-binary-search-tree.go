func searchBST(root *TreeNode, val int) *TreeNode {
    curr := root
    for curr != nil {
        if curr.Val == val {
            return curr
        } else if val < curr.Val {
            curr = curr.Left
        } else {
            curr = curr.Right
        }
    }
    return nil
}