/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
    stack1, stack2 := []int{}, []int{}

    for l1 != nil {
        stack1 = append(stack1, l1.Val)
        l1 = l1.Next
    }

    for l2 != nil {
        stack2 = append(stack2, l2.Val)
        l2 = l2.Next
    }

    carry := 0
    var result *ListNode

    for len(stack1) > 0 || len(stack2) > 0 || carry > 0 {
        sum := carry
        if len(stack1) > 0 {
            sum += stack1[len(stack1)-1]
            stack1 = stack1[:len(stack1)-1]
        }
        if len(stack2) > 0 {
            sum += stack2[len(stack2)-1]
            stack2 = stack2[:len(stack2)-1]
        }

        carry = sum / 10
        newNode := &ListNode{Val: sum % 10}
        newNode.Next = result
        result = newNode
    }

    return result
}