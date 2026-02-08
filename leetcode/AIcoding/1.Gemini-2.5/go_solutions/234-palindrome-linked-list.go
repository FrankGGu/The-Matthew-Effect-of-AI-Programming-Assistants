func isPalindrome(head *ListNode) bool {
    if head == nil || head.Next == nil {
        return true
    }

    slow := head
    fast := head
    var prev *ListNode

    for fast != nil && fast.Next != nil {
        prev = slow
        slow = slow.Next
        fast = fast.Next.Next
    }

    var firstHalfEnd *ListNode
    var secondHalfStart *ListNode

    if fast != nil {
        firstHalfEnd = prev
        secondHalfStart = slow.Next
    } else {
        firstHalfEnd = prev
        secondHalfStart = slow
    }

    if firstHalfEnd != nil {
        firstHalfEnd.Next = nil
    }

    secondHalfReversed := reverseList(secondHalfStart)

    p1 := head
    p2 := secondHalfReversed
    isPal := true

    for p1 != nil && p2 != nil {
        if p1.Val != p2.Val {
            isPal = false
            break
        }
        p1 = p1.Next
        p2 = p2.Next
    }

    secondHalfRestored := reverseList(secondHalfReversed)

    if firstHalfEnd != nil {
        if fast != nil {
            firstHalfEnd.Next = slow
            slow.Next = secondHalfRestored
        } else {
            firstHalfEnd.Next = secondHalfRestored
        }
    }

    return isPal
}

func reverseList(head *ListNode) *ListNode {
    var prev *ListNode
    curr := head
    for curr != nil {
        nextTemp := curr.Next
        curr.Next = prev
        prev = curr
        curr = nextTemp
    }
    return prev
}