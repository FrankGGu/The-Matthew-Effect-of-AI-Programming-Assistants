/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func sortList(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    slow, fast := head, head.Next
    for fast != nil && fast.Next != nil {
        slow = slow.Next
        fast = fast.Next.Next
    }
    mid := slow.Next
    slow.Next = nil

    left := sortList(head)
    right := sortList(mid)

    dummy := &ListNode{}
    current := dummy

    for left != nil && right != nil {
        if left.Val < right.Val {
            current.Next = left
            left = left.Next
        } else {
            current.Next = right
            right = right.Next
        }
        current = current.Next
    }

    if left != nil {
        current.Next = left
    } else {
        current.Next = right
    }

    return dummy.Next
}