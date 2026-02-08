/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func reverseBetween(head *ListNode, left int, right int) *ListNode {
    if head == nil || left == right {
        return head
    }

    dummy := &ListNode{Next: head}
    prev := dummy

    for i := 0; i < left-1; i++ {
        prev = prev.Next
    }

    current := prev.Next
    for i := 0; i < right-left; i++ {
        next := current.Next
        current.Next = next.Next
        next.Next = prev.Next
        prev.Next = next
    }

    return dummy.Next
}