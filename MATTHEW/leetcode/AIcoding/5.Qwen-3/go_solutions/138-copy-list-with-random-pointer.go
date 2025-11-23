package main



func copyRandomList(head *Node) *Node {
    if head == nil {
        return nil
    }

    nodeMap := make(map[*Node]*Node)
    current := head

    for current != nil {
        nodeMap[current] = &Node{Val: current.Val}
        current = current.Next
    }

    current = head
    for current != nil {
        nodeMap[current].Next = nodeMap[current.Next]
        nodeMap[current].Random = nodeMap[current.Random]
        current = current.Next
    }

    return nodeMap[head]
}