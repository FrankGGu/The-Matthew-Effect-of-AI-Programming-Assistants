func connect(root *Node) *Node {
    if root == nil {
        return nil
    }

    levelStart := root
    for levelStart.Left != nil {
        curr := levelStart
        for curr != nil {
            curr.Left.Next = curr.Right
            if curr.Next != nil {
                curr.Right.Next = curr.Next.Left
            }
            curr = curr.Next
        }
        levelStart = levelStart.Left
    }
    return root
}