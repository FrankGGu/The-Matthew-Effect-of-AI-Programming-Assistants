/**
 * Definition for a Node.
 * type Node struct {
 *     Val int
 *     Left *Node
 *     Right *Node
 * }
 */

func treeToDoublyList(root *Node) *Node {
    if root == nil {
        return nil
    }

    var prev *Node
    var head *Node

    var inorder func(node *Node)
    inorder = func(node *Node) {
        if node == nil {
            return
        }
        inorder(node.Left)
        if prev == nil {
            head = node
        } else {
            prev.Right = node
            node.Left = prev
        }
        prev = node
        inorder(node.Right)
    }

    inorder(root)
    head.Left = prev
    prev.Right = head

    return head
}