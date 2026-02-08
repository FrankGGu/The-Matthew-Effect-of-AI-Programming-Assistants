package main

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func deleteNode(root *TreeNode, key int) *TreeNode {
    if root == nil {
        return nil
    }
    if key < root.Val {
        root.Left = deleteNode(root.Left, key)
    } else if key > root.Val {
        root.Right = deleteNode(root.Right, key)
    } else {
        if root.Left == nil {
            return root.Right
        } else if root.Right == nil {
            return root.Left
        }
        minNode := root.Right
        for minNode.Left != nil {
            minNode = minNode.Left
        }
        root.Val = minNode.Val
        root.Right = deleteNode(root.Right, minNode.Val)
    }
    return root
}