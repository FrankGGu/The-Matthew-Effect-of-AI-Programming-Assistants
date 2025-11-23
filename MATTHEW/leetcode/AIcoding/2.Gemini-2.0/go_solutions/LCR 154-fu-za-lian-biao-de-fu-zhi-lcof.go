func copyRandomList(head *Node) *Node {
    if head == nil {
        return nil
    }

    nodeMap := make(map[*Node]*Node)

    curr := head
    for curr != nil {
        nodeMap[curr] = &Node{Val: curr.Val}
        curr = curr.Next
    }

    curr = head
    for curr != nil {
        nodeMap[curr].Next = nodeMap[curr.Next]
        nodeMap[curr].Random = nodeMap[curr.Random]
        curr = curr.Next
    }

    return nodeMap[head]
}