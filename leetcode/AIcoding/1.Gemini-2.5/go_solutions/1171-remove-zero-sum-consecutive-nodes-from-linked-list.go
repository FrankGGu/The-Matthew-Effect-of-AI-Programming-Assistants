func removeZeroSumSublists(head *ListNode) *ListNode {
    dummy := &ListNode{Val: 0, Next: head}
    prefixSumMap := make(map[int]*ListNode)

    prefixSumMap[0] = dummy

    currentSum := 0
    current := dummy

    for current != nil {
        currentSum += current.Val

        if node, found := prefixSumMap[currentSum]; found {
            s := currentSum 
            temp := node.Next

            for temp != current {
                s += temp.Val
                delete(prefixSumMap, s)
                temp = temp.Next
            }

            node.Next = current.Next
            current = node

        } else {
            prefixSumMap[currentSum] = current
        }

        current = current.Next
    }

    return dummy.Next
}