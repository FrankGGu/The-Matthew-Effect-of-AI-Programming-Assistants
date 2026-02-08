type Node struct {
    Val   int
    Left  *Node
    Right *Node
}

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
        if prev != nil {
            prev.Right = node
            node.Left = prev
        } else {
            head = node
        }
        prev = node
        inorder(node.Right)
    }

    inorder(root)
    head.Left = prev
    prev.Right = head

    return head
}