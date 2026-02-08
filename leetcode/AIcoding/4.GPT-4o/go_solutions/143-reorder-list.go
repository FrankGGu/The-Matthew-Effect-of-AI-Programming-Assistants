type ListNode struct {
    Val  int
    Next *ListNode
}

func reorderList(head *ListNode) {
    if head == nil || head.Next == nil {
        return
    }

    // Step 1: Find the middle of the list
    slow, fast := head, head
    for fast != nil && fast.Next != nil {
        slow = slow.Next
        fast = fast.Next.Next
    }

    // Step 2: Reverse the second half of the list
    var prev *ListNode
    curr := slow
    for curr != nil {
        next := curr.Next
        curr.Next = prev
        prev = curr
        curr = next
    }

    // Step 3: Merge the two halves
    first, second := head, prev
    for second.Next != nil {
        tmp1, tmp2 := first.Next, second.Next
        first.Next = second
        second.Next = tmp1

        first = tmp1
        second = tmp2
    }
}