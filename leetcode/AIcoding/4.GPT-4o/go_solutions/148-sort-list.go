type ListNode struct {
    Val  int
    Next *ListNode
}

func sortList(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    mid := getMiddle(head)
    left := sortList(head)
    right := sortList(mid)

    return merge(left, right)
}

func getMiddle(head *ListNode) *ListNode {
    if head == nil {
        return head
    }
    slow, fast := head, head
    var prev *ListNode
    for fast != nil && fast.Next != nil {
        prev = slow
        slow = slow.Next
        fast = fast.Next.Next
    }
    if prev != nil {
        prev.Next = nil
    }
    return slow
}

func merge(left, right *ListNode) *ListNode {
    dummy := &ListNode{}
    tail := dummy

    for left != nil && right != nil {
        if left.Val < right.Val {
            tail.Next = left
            left = left.Next
        } else {
            tail.Next = right
            right = right.Next
        }
        tail = tail.Next
    }
    if left != nil {
        tail.Next = left
    }
    if right != nil {
        tail.Next = right
    }
    return dummy.Next
}