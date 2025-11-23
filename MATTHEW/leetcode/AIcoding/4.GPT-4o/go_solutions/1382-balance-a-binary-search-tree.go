package main

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func balanceBST(root *TreeNode) *TreeNode {
    var inorder func(node *TreeNode) []*TreeNode
    inorder = func(node *TreeNode) []*TreeNode {
        if node == nil {
            return nil
        }
        return append(append(inorder(node.Left), node), inorder(node.Right)...)
    }

    nodes := inorder(root)

    var build func(left, right int) *TreeNode
    build = func(left, right int) *TreeNode {
        if left > right {
            return nil
        }
        mid := (left + right) / 2
        node := nodes[mid]
        node.Left = build(left, mid-1)
        node.Right = build(mid+1, right)
        return node
    }

    return build(0, len(nodes)-1)
}