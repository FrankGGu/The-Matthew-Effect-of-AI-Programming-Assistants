/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func mergeNodes(head *ListNode) *ListNode {
    dummy := &ListNode{}
    current := dummy
    sum := 0
    node := head.Next

    for node != nil {
        if node.Val == 0 {
            current.Next = &ListNode{Val: sum}
            current = current.Next
            sum = 0
        } else {
            sum += node.Val
        }
        node = node.Next
    }

    return dummy.Next
}