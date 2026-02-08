func mergeInBetween(list1 *ListNode, a int, b int, list2 *ListNode) *ListNode {
    var start *ListNode
    var end *ListNode

    curr := list1
    idx := 0

    for curr != nil {
        if idx == a - 1 {
            start = curr
        }
        if idx == b {
            end = curr.Next
        }
        curr = curr.Next
        idx++
    }

    start.Next = list2

    curr = list2
    for curr.Next != nil {
        curr = curr.Next
    }

    curr.Next = end

    return list1
}