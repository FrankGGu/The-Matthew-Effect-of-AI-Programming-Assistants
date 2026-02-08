package main


func reverseEvenLengthGroups(head *ListNode) *ListNode {
    var prev *ListNode
    var curr *ListNode = head
    var count int = 0
    var groupSize int = 1

    for curr != nil {
        count++
        if count == groupSize {
            // Reverse the group
            var next *ListNode = curr.Next
            var newPrev *ListNode = prev
            var newCurr *ListNode = curr
            var i int = 0
            for i < groupSize {
                var temp *ListNode = newCurr.Next
                newCurr.Next = newPrev
                newPrev = newCurr
                newCurr = temp
                i++
            }
            if prev != nil {
                prev.Next = newPrev
            } else {
                head = newPrev
            }
            prev = curr
            curr = newCurr
            groupSize++
            count = 0
        } else {
            curr = curr.Next
        }
    }

    return head
}