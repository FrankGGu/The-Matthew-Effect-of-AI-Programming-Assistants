package main

type Node struct {
    Val   int
    Left  *Node
    Right *Node
}

func treeToDoublyList(root *Node) *Node {
    if root == nil {
        return nil
    }

    var prev, head *Node

    var dfs func(*Node)
    dfs = func(node *Node) {
        if node == nil {
            return
        }
        dfs(node.Left)
        if prev != nil {
            prev.Right = node
            node.Left = prev
        } else {
            head = node
        }
        prev = node
        dfs(node.Right)
    }

    dfs(root)
    head.Left = prev
    prev.Right = head

    return head
}