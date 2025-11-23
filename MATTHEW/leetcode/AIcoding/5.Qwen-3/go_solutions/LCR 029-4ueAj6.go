package main

type Node struct {
    val  int
    next *Node
}

func insert(head *Node, insertVal int) *Node {
    if head == nil {
        newNode := &Node{val: insertVal}
        newNode.next = newNode
        return newNode
    }

    current := head
    for {
        if current.val <= insertVal && current.next.val >= insertVal {
            break
        }
        if current.next.val < current.val && (insertVal < current.next.val || insertVal > current.val) {
            break
        }
        current = current.next
        if current == head {
            break
        }
    }

    newNode := &Node{val: insertVal}
    newNode.next = current.next
    current.next = newNode

    return head
}