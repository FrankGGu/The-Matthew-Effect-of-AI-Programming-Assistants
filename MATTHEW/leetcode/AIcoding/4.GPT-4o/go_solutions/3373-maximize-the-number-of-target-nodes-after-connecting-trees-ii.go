type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func maximizeTargetNodes(root1 *TreeNode, root2 *TreeNode) int {
    count1 := countTargetNodes(root1)
    count2 := countTargetNodes(root2)
    return count1 + count2
}

func countTargetNodes(node *TreeNode) int {
    if node == nil {
        return 0
    }
    leftCount := countTargetNodes(node.Left)
    rightCount := countTargetNodes(node.Right)
    return 1 + leftCount + rightCount
}