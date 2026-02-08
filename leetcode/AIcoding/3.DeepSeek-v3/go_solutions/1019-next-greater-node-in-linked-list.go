/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func nextLargerNodes(head *ListNode) []int {
    var nums []int
    for head != nil {
        nums = append(nums, head.Val)
        head = head.Next
    }

    stack := make([]int, 0)
    res := make([]int, len(nums))
    for i := len(nums) - 1; i >= 0; i-- {
        for len(stack) > 0 && stack[len(stack)-1] <= nums[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) > 0 {
            res[i] = stack[len(stack)-1]
        } else {
            res[i] = 0
        }
        stack = append(stack, nums[i])
    }
    return res
}