/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func rotateRight(head *ListNode, k int) *ListNode {
    if head == nil || head.Next == nil || k == 0 {
        return head
    }

    length := 1
    tail := head
    for tail.Next != nil {
        tail = tail.Next
        length++
    }

    k = k % length
    if k == 0 {
        return head
    }

    steps := length - k - 1
    newTail := head
    for steps > 0 {
        newTail = newTail.Next
        steps--
    }

    newHead := newTail.Next
    newTail.Next = nil
    tail.Next = head

    return newHead
}