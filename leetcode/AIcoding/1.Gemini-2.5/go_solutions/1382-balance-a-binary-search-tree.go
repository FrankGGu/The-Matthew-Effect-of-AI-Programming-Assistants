func balanceBST(root *TreeNode) *TreeNode {
    var nodes []*TreeNode

    var inorderTraversal func(*TreeNode)
    inorderTraversal = func(node *TreeNode) {
        if node == nil {
            return
        }
        inorderTraversal(node.Left)
        nodes = append(nodes, node)
        inorderTraversal(node.Right)
    }

    inorderTraversal(root)

    var buildBalancedBST func([]*TreeNode, int, int) *TreeNode
    buildBalancedBST = func(nodes []*TreeNode, start, end int) *TreeNode {
        if start > end {
            return nil
        }
        mid := start + (end-start)/2
        root := nodes[mid]
        root.Left = buildBalancedBST(nodes, start, mid-1)
        root.Right = buildBalancedBST(nodes, mid+1, end)
        return root
    }

    return buildBalancedBST(nodes, 0, len(nodes)-1)
}