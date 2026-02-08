package main


func pairSum(head *ListNode) int {
    var slow, fast *ListNode = head, head
    var prev *ListNode = nil
    for fast != nil && fast.Next != nil {
        fast = fast.Next.Next
        next := slow.Next
        slow.Next = prev
        prev = slow
        slow = next
    }
    var maxSum int = 0
    for slow != nil {
        if prev.Val+slow.Val > maxSum {
            maxSum = prev.Val + slow.Val
        }
        prev = prev.Next
        slow = slow.Next
    }
    return maxSum
}