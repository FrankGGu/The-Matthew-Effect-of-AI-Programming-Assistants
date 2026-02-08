/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func partition(head *ListNode, x int) *ListNode {
    beforeHead := &ListNode{}
    before := beforeHead
    afterHead := &ListNode{}
    after := afterHead

    for head != nil {
        if head.Val < x {
            before.Next = head
            before = before.Next
        } else {
            after.Next = head
            after = after.Next
        }
        head = head.Next
    }

    after.Next = nil
    before.Next = afterHead.Next

    return beforeHead.Next
}