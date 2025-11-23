func getDecimalValue(head *ListNode) int {
    result := 0
    current := head
    for current != nil {
        result = result*2 + current.Val
        current = current.Next
    }
    return result
}