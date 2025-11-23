/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func mergeInBetween(list1 *ListNode, a int, b int, list2 *ListNode) *ListNode {
    dummy := &ListNode{Next: list1}
    prevA := dummy
    for i := 0; i < a; i++ {
        prevA = prevA.Next
    }

    nodeB := prevA
    for i := a; i <= b; i++ {
        nodeB = nodeB.Next
    }

    prevA.Next = list2

    tailList2 := list2
    for tailList2.Next != nil {
        tailList2 = tailList2.Next
    }

    tailList2.Next = nodeB.Next

    return dummy.Next
}