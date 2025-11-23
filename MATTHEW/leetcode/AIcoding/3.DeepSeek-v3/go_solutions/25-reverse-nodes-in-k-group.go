/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func reverseKGroup(head *ListNode, k int) *ListNode {
    if head == nil || k == 1 {
        return head
    }

    dummy := &ListNode{Next: head}
    prev := dummy

    for head != nil {
        tail := prev
        for i := 0; i < k; i++ {
            tail = tail.Next
            if tail == nil {
                return dummy.Next
            }
        }
        next := tail.Next
        head, tail = reverse(head, tail)
        prev.Next = head
        tail.Next = next
        prev = tail
        head = tail.Next
    }

    return dummy.Next
}

func reverse(head, tail *ListNode) (*ListNode, *ListNode) {
    prev := tail.Next
    curr := head
    for prev != tail {
        next := curr.Next
        curr.Next = prev
        prev = curr
        curr = next
    }
    return tail, head
}