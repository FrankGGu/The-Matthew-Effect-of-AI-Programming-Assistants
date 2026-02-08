/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func pairSum(head *ListNode) int {
    slow, fast := head, head
    var prev *ListNode
    for fast != nil && fast.Next != nil {
        fast = fast.Next.Next
        next := slow.Next
        slow.Next = prev
        prev = slow
        slow = next
    }

    maxSum := 0
    for prev != nil {
        sum := prev.Val + slow.Val
        if sum > maxSum {
            maxSum = sum
        }
        prev = prev.Next
        slow = slow.Next
    }
    return maxSum
}