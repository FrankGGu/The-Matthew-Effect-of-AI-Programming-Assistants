/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func reverseEvenLengthGroups(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }

    dummy := &ListNode{Next: head}
    prev := dummy
    groupSize := 1

    for prev.Next != nil {
        count := 0
        curr := prev.Next
        var tail *ListNode

        for count < groupSize && curr != nil {
            tail = curr
            curr = curr.Next
            count++
        }

        if count % 2 == 0 {
            nextGroup := tail.Next
            newHead, newTail := reverseList(prev.Next, tail)
            prev.Next = newHead
            newTail.Next = nextGroup
            prev = newTail
        } else {
            prev = tail
        }

        groupSize++
    }

    return dummy.Next
}

func reverseList(head, tail *ListNode) (*ListNode, *ListNode) {
    var prev *ListNode
    curr := head
    end := tail.Next

    for curr != end {
        next := curr.Next
        curr.Next = prev
        prev = curr
        curr = next
    }

    return prev, head
}