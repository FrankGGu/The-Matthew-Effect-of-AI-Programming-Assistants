package main


func mergeInBetween(list1 *ListNode, a int, b int, list2 *ListNode) *ListNode {
    var prev *ListNode
    current := list1
    for i := 0; i < a; i++ {
        prev = current
        current = current.Next
    }
    end := current
    for i := 0; i <= b-a; i++ {
        end = end.Next
    }
    prev.Next = list2
    for list2.Next != nil {
        list2 = list2.Next
    }
    list2.Next = end
    return list1
}