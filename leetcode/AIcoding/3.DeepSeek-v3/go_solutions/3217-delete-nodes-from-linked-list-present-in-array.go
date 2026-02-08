/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func deleteNodes(head *ListNode, to_delete []int) *ListNode {
    deleteSet := make(map[int]bool)
    for _, num := range to_delete {
        deleteSet[num] = true
    }

    dummy := &ListNode{Val: 0, Next: head}
    prev := dummy
    current := head

    for current != nil {
        if deleteSet[current.Val] {
            prev.Next = current.Next
        } else {
            prev = current
        }
        current = current.Next
    }

    return dummy.Next
}