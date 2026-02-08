func closestKValues(root *TreeNode, target float64, k int) []int {
    var result []int
    var inOrder func(node *TreeNode)
    var values []int

    inOrder = func(node *TreeNode) {
        if node == nil {
            return
        }
        inOrder(node.Left)
        values = append(values, node.Val)
        inOrder(node.Right)
    }

    inOrder(root)

    sort.Slice(values, func(i, j int) bool {
        return math.Abs(float64(values[i])-target) < math.Abs(float64(values[j])-target)
    })

    if k > len(values) {
        k = len(values)
    }

    return values[:k]
}