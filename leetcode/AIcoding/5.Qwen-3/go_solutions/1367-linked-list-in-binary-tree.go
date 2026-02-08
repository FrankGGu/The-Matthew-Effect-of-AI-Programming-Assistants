package main



func isSubPath(head *ListNode, root *TreeNode) bool {
    if head == nil {
        return true
    }
    if root == nil {
        return false
    }
    return dfs(head, root) || isSubPath(head, root.Left) || isSubPath(head, root.Right)
}

func dfs(head *ListNode, root *TreeNode) bool {
    if head == nil {
        return true
    }
    if root == nil {
        return false
    }
    if head.Val != root.Val {
        return false
    }
    return dfs(head.Next, root.Left) || dfs(head.Next, root.Right)
}