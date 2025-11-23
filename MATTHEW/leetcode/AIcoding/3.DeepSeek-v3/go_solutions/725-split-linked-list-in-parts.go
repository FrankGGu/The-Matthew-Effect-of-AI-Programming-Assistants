/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func splitListToParts(head *ListNode, k int) []*ListNode {
    length := 0
    for curr := head; curr != nil; curr = curr.Next {
        length++
    }

    partSize := length / k
    extra := length % k

    res := make([]*ListNode, k)
    curr := head

    for i := 0; i < k && curr != nil; i++ {
        res[i] = curr
        size := partSize
        if extra > 0 {
            size++
            extra--
        }

        for j := 0; j < size-1; j++ {
            curr = curr.Next
        }

        next := curr.Next
        curr.Next = nil
        curr = next
    }

    return res
}