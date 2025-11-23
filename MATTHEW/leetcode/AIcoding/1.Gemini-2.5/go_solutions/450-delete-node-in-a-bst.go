func deleteNode(root *TreeNode, key int) *TreeNode {
    if root == nil {
        return nil
    }

    if key < root.Val {
        root.Left = deleteNode(root.Left, key)
    } else if key > root.Val {
        root.Right = deleteNode(root.Right, key)
    } else {
        // Node to be deleted found

        // Case 1: Node has no left child (or is a leaf node)
        if root.Left == nil {
            return root.Right
        }
        // Case 2: Node has no right child
        if root.Right == nil {
            return root.Left
        }

        // Case 3: Node has two children
        // Find the in-order successor (smallest node in the right subtree)
        minNode := findMin(root.Right)
        // Replace the current node's value with the successor's value
        root.Val = minNode.Val
        // Delete the successor from the right subtree
        root.Right = deleteNode(root.Right, minNode.Val)
    }
    return root
}

func findMin(node *TreeNode) *TreeNode {
    curr := node
    for curr.Left != nil {
        curr = curr.Left
    }
    return curr
}