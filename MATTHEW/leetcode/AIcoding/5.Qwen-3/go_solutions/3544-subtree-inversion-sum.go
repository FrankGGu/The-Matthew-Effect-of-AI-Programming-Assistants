package main


func subtreeSum(root *TreeNode) int {
    if root == nil {
        return 0
    }
    sum := root.Val
    sum += subtreeSum(root.Left)
    sum += subtreeSum(root.Right)
    return sum
}

func invertTree(root *TreeNode) *TreeNode {
    if root == nil {
        return nil
    }
    left := invertTree(root.Left)
    right := invertTree(root.Right)
    root.Left = right
    root.Right = left
    return root
}

func isSubtree(t *TreeNode, s *TreeNode) bool {
    if t == nil {
        return false
    }
    if isSameTree(t, s) {
        return true
    }
    return isSubtree(t.Left, s) || isSubtree(t.Right, s)
}

func isSameTree(t *TreeNode, s *TreeNode) bool {
    if t == nil && s == nil {
        return true
    }
    if t == nil || s == nil {
        return false
    }
    return t.Val == s.Val && isSameTree(t.Left, s.Left) && isSameTree(t.Right, s.Right)
}

func findSubtreeInversionSum(root *TreeNode) int {
    if root == nil {
        return 0
    }
    total := 0
    queue := []*TreeNode{root}
    for len(queue) > 0 {
        node := queue[0]
        queue = queue[1:]
        if isSubtree(node, root) {
            inverted := invertTree(root)
            total += subtreeSum(inverted)
        }
        if node.Left != nil {
            queue = append(queue, node.Left)
        }
        if node.Right != nil {
            queue = append(queue, node.Right)
        }
    }
    return total
}