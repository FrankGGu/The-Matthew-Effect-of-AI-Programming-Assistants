package main


func trainningPlan(head *ListNode, cnt int) *ListNode {
    fast := head
    for i := 0; i < cnt; i++ {
        fast = fast.Next
    }
    slow := head
    for fast != nil {
        fast = fast.Next
        slow = slow.Next
    }
    return slow
}