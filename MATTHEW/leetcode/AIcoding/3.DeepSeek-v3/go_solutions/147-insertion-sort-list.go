/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func insertionSortList(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    dummy := &ListNode{Next: head}
    prev, curr := head, head.Next

    for curr != nil {
        if curr.Val >= prev.Val {
            prev, curr = curr, curr.Next
            continue
        }

        temp := dummy
        for temp.Next.Val < curr.Val {
            temp = temp.Next
        }

        prev.Next = curr.Next
        curr.Next = temp.Next
        temp.Next = curr
        curr = prev.Next
    }

    return dummy.Next
}