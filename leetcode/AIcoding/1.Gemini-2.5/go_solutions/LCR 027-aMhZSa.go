func isPalindrome(head *ListNode) bool {
    if head == nil || head.Next == nil {
        return true
    }

    slow := head
    fast := head
    for fast.Next != nil && fast.Next.Next != nil {
        slow = slow.Next
        fast = fast.Next.Next
    }

    secondHalfHead := reverseList(slow.Next)
    slow.Next = nil 

    p1 := head
    p2 := secondHalfHead
    for p1 != nil && p2 != nil {
        if p1.Val != p2.Val {
            return false
        }
        p1 = p1.Next
        p2 = p2.Next
    }

    return true
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