func closestNodes(root *TreeNode, queries []int) [][]int {
    inorder := []int{}
    var inorderTraversal func(*TreeNode)
    inorderTraversal = func(node *TreeNode) {
        if node == nil {
            return
        }
        inorderTraversal(node.Left)
        inorder = append(inorder, node.Val)
        inorderTraversal(node.Right)
    }

    inorderTraversal(root)

    result := [][]int{}
    for _, query := range queries {
        lower := -1
        upper := -1

        l, r := 0, len(inorder)-1
        for l <= r {
            mid := l + (r-l)/2
            if inorder[mid] <= query {
                lower = inorder[mid]
                l = mid + 1
            } else {
                r = mid - 1
            }
        }

        l, r = 0, len(inorder)-1
        for l <= r {
            mid := l + (r-l)/2
            if inorder[mid] >= query {
                upper = inorder[mid]
                r = mid - 1
            } else {
                l = mid + 1
            }
        }

        result = append(result, []int{lower, upper})
    }

    return result
}