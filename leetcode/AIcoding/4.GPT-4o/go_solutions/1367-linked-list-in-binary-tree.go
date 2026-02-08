/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val  int
 *     Next *ListNode
 * }
 */

func isSubPath(head *ListNode, root *TreeNode) bool {
    if root == nil {
        return false
    }

    return dfs(head, root) || isSubPath(head, root.Left) || isSubPath(head, root.Right)
}

func dfs(head *ListNode, root *TreeNode) bool {
    if head == nil {
        return true
    }
    if root == nil || root.Val != head.Val {
        return false
    }

    return dfs(head.Next, root.Left) || dfs(head.Next, root.Right)
}