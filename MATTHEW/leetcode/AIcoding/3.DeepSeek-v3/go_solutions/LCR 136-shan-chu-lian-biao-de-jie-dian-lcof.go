/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func deleteNode(head *ListNode, val int) *ListNode {
    if head == nil {
        return nil
    }
    if head.Val == val {
        return head.Next
    }
    prev, curr := head, head.Next
    for curr != nil {
        if curr.Val == val {
            prev.Next = curr.Next
            break
        }
        prev = curr
        curr = curr.Next
    }
    return head
}