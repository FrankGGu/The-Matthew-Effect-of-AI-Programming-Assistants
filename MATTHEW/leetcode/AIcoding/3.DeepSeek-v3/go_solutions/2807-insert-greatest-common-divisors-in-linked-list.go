/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func insertGreatestCommonDivisors(head *ListNode) *ListNode {
    if head == nil || head.Next == nil {
        return head
    }
    current := head
    for current != nil && current.Next != nil {
        gcdVal := gcd(current.Val, current.Next.Val)
        newNode := &ListNode{Val: gcdVal, Next: current.Next}
        current.Next = newNode
        current = newNode.Next
    }
    return head
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}