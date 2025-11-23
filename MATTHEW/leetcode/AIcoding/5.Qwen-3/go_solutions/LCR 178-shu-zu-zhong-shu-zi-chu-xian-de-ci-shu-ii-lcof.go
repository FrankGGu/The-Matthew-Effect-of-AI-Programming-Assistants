package main

func trainingPlan(head *ListNode, k int) *ListNode {
    slow, fast := head, head
    for i := 0; i < k; i++ {
        if fast == nil {
            return head
        }
        fast = fast.Next
    }
    for fast != nil {
        slow = slow.Next
        fast = fast.Next
    }
    return slow
}