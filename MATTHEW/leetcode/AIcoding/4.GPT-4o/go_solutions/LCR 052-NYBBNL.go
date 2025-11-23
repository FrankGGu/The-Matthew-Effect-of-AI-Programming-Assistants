package main

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func increasingBST(root *TreeNode) *TreeNode {
    var vals []int
    var inorder func(node *TreeNode)
    inorder = func(node *TreeNode) {
        if node == nil {
            return
        }
        inorder(node.Left)
        vals = append(vals, node.Val)
        inorder(node.Right)
    }
    inorder(root)

    dummy := &TreeNode{}
    current := dummy
    for _, val := range vals {
        current.Right = &TreeNode{Val: val}
        current = current.Right
    }
    return dummy.Right
}