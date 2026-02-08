/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func removeZeroSumSublists(head *ListNode) *ListNode {
    dummy := &ListNode{0, head}
    prefix := 0
    seen := make(map[int]*ListNode)
    seen[0] = dummy

    for current := dummy; current != nil; current = current.Next {
        prefix += current.Val
        seen[prefix] = current
    }

    prefix = 0
    for current := dummy; current != nil; current = current.Next {
        prefix += current.Val
        current.Next = seen[prefix].Next
    }

    return dummy.Next
}