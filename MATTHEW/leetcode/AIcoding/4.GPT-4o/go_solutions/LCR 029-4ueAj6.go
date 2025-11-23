type Node struct {
    Val  int
    Next *Node
}

func insert(head *Node, insertVal int) *Node {
    newNode := &Node{Val: insertVal}
    if head == nil {
        newNode.Next = newNode
        return newNode
    }

    prev, curr := head, head.Next
    for {
        if prev.Val <= insertVal && insertVal <= curr.Val {
            break
        }
        if prev.Val > curr.Val {
            if insertVal >= prev.Val || insertVal <= curr.Val {
                break
            }
        }
        prev = curr
        curr = curr.Next
        if prev == head {
            break
        }
    }
    prev.Next = newNode
    newNode.Next = curr
    return head
}