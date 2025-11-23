func sortList(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    // Find the middle of the list using slow and fast pointers
    var prev *ListNode
    slow, fast := head, head
    for fast != nil && fast.Next != nil {
        prev = slow
        slow = slow.Next
        fast = fast.Next.Next
    }

    // Split the list into two halves
    // 'prev' is the node before 'slow', so 'prev.Next' points to 'slow'
    // Set 'prev.Next' to nil to break the link and form the first half
    if prev != nil {
        prev.Next = nil
    }

    // Recursively sort the two halves
    l1 := sortList(head)
    l2 := sortList(slow) // 'slow' is the head of the second half

    // Merge the two sorted halves
    return merge(l1, l2)
}

func merge(l1 *ListNode, l2 *ListNode) *ListNode {
    dummy := &ListNode{}
    current := dummy

    for l1 != nil && l2 != nil {
        if l1.Val < l2.Val {
            current.Next = l1
            l1 = l1.Next
        } else {
            current.Next = l2
            l2 = l2.Next
        }
        current = current.Next
    }

    // Append any remaining nodes from l1 or l2
    if l1 != nil {
        current.Next = l1
    } else if l2 != nil {
        current.Next = l2
    }

    return dummy.Next
}