func removeNodes(head *ListNode) *ListNode {
    if head == nil {
        return nil
    }

    reverseList := func(node *ListNode) *ListNode {
        var prev *ListNode
        curr := node
        for curr != nil {
            nextTemp := curr.Next
            curr.Next = prev
            prev = curr
            curr = nextTemp
        }
        return prev
    }

    reversedHead := reverseList(head)

    var resultHead *ListNode
    currentMax := 0

    curr := reversedHead
    for curr != nil {
        if curr.Val >= currentMax {
            currentMax = curr.Val

            tempNext := curr.Next
            curr.Next = resultHead
            resultHead = curr
            curr = tempNext
        } else {
            curr = curr.Next
        }
    }

    return resultHead
}