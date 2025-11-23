/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func swapNodes(head *ListNode, k int) *ListNode {
    if head == nil {
        return nil
    }

    var first *ListNode
    var second *ListNode
    fast := head
    slow := head

    for i := 1; i < k; i++ {
        fast = fast.Next
    }
    first = fast

    for fast.Next != nil {
        slow = slow.Next
        fast = fast.Next
    }
    second = slow

    first.Val, second.Val = second.Val, first.Val

    return head
}