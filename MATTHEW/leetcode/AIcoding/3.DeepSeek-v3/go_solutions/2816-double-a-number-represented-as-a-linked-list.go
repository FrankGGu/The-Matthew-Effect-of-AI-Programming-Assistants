/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func doubleIt(head *ListNode) *ListNode {
    var prev *ListNode
    curr := head

    for curr != nil {
        next := curr.Next
        curr.Next = prev
        prev = curr
        curr = next
    }

    carry := 0
    curr = prev
    var newPrev *ListNode

    for curr != nil {
        doubled := curr.Val * 2 + carry
        curr.Val = doubled % 10
        carry = doubled / 10
        next := curr.Next
        curr.Next = newPrev
        newPrev = curr
        curr = next
    }

    if carry > 0 {
        newPrev = &ListNode{Val: carry, Next: newPrev}
    }

    return newPrev
}