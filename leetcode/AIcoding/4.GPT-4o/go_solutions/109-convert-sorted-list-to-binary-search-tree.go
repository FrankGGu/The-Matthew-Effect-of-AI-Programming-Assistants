/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */

/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func sortedListToBST(head *ListNode) *TreeNode {
    if head == nil {
        return nil
    }

    var findMiddle func(left, right *ListNode) *ListNode
    findMiddle = func(left, right *ListNode) *ListNode {
        fast := left
        slow := left
        for fast != right && fast.Next != right {
            fast = fast.Next.Next
            slow = slow.Next
        }
        return slow
    }

    var convert func(left, right *ListNode) *TreeNode
    convert = func(left, right *ListNode) *TreeNode {
        if left == right {
            return nil
        }

        mid := findMiddle(left, right)
        node := &TreeNode{Val: mid.Val}
        node.Left = convert(left, mid)
        node.Right = convert(mid.Next, right)
        return node
    }

    return convert(head, nil)
}