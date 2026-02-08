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
        copiedNode := nodeMap[curr]
        copiedNode.Next = nodeMap[curr.Next]
        copiedNode.Random = nodeMap[curr.Random]
        curr = curr.Next