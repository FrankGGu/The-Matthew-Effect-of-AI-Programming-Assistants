/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func numComponents(head *ListNode, nums []int) int {
    numSet := make(map[int]bool)
    for _, num := range nums {
        numSet[num] = true
    }

    res := 0
    inComponent := false

    for head != nil {
        if numSet[head.Val] {
            if !inComponent {
                res++
                inComponent = true
            }
        } else {
            inComponent = false
        }
        head = head.Next
    }

    return res
}