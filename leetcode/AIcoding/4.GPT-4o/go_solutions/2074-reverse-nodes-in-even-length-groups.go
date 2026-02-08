type ListNode struct {
    Val  int
    Next *ListNode
}

func reverseEvenLengthGroups(head *ListNode) *ListNode {
    dummy := &ListNode{Next: head}
    prevGroupEnd := dummy
    groupSize := 1
    current := head

    for current != nil {
        groupHead := current
        count := 0

        for count < groupSize && current != nil {
            current = current.Next
            count++
        }

        if count%2 == 0 {
            prevGroupEnd.Next = reverseList(groupHead, count)
            groupHead.Next = current
        } else {
            prevGroupEnd.Next = groupHead
        }

        prevGroupEnd = groupHead
        groupSize++
    }

    return dummy.Next
}

func reverseList(head *ListNode, count int) *ListNode {
    var prev *ListNode
    current := head
    for count > 0 {
        next := current.Next
        current.Next = prev
        prev = current
        current = next
        count--
    }
    return prev
}