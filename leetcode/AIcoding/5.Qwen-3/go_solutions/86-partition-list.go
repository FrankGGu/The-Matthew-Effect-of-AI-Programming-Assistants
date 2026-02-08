package main


func partition(head *ListNode, x int) *ListNode {
    dummyLess := &ListNode{}
    dummyGreater := &ListNode{}
    less := dummyLess
    greater := dummyGreater

    for head != nil {
        if head.Val < x {
            less.Next = head
            less = less.Next
        } else {
            greater.Next = head
            greater = greater.Next
        }
        head = head.Next
    }

    less.Next = dummyGreater.Next
    greater.Next = nil

    return dummyLess.Next
}