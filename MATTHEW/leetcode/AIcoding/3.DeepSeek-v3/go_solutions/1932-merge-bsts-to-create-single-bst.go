/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */

func canMerge(trees []*TreeNode) *TreeNode {
    valueToRoot := make(map[int]*TreeNode)
    valueToParent := make(map[int]*TreeNode)
    values := make(map[int]bool)

    for _, root := range trees {
        valueToRoot[root.Val] = root
        values[root.Val] = true
        var traverse func(node *TreeNode)
        traverse = func(node *TreeNode) {
            if node == nil {
                return
            }
            if node.Left != nil {
                valueToParent[node.Left.Val] = node
                traverse(node.Left)
            }
            if node.Right != nil {
                valueToParent[node.Right.Val] = node
                traverse(node.Right)
            }
        }
        traverse(root)
    }

    var root *TreeNode
    for val, node := range valueToRoot {
        if _, exists := valueToParent[val]; !exists {
            if root != nil {
                return nil
            }
            root = node
        }
    }
    if root == nil {
        return nil
    }

    delete(valueToRoot, root.Val)
    q := []*TreeNode{root}
    for len(q) > 0 {
        node := q[0]
        q = q[1:]

        if node.Left != nil && node.Left.Left == nil && node.Left.Right == nil {
            if leftRoot, exists := valueToRoot[node.Left.Val]; exists {
                node.Left = leftRoot
                delete(valueToRoot, leftRoot.Val)
                q = append(q, leftRoot)
            }
        }
        if node.Right != nil && node.Right.Left == nil && node.Right.Right == nil {
            if rightRoot, exists := valueToRoot[node.Right.Val]; exists {
                node.Right = rightRoot
                delete(valueToRoot, rightRoot.Val)
                q = append(q, rightRoot)
            }
        }
    }

    if len(valueToRoot) > 0 {
        return nil
    }

    prev := -1 << 31
    valid := true
    var inorder func(*TreeNode)
    inorder = func(node *TreeNode) {
        if node == nil || !valid {
            return
        }
        inorder(node.Left)
        if node.Val <= prev {
            valid = false
            return
        }
        prev = node.Val
        inorder(node.Right)
    }
    inorder(root)

    if valid {
        return root
    }
    return nil
}