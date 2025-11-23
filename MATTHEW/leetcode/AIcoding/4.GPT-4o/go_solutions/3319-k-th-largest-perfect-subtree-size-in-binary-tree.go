type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func kthLargestPerfectSubtreeSize(root *TreeNode, k int) int {
    sizes := []int{}
    var dfs func(node *TreeNode) (int, bool)
    dfs = func(node *TreeNode) (int, bool) {
        if node == nil {
            return 0, true
        }
        leftSize, isPerfectLeft := dfs(node.Left)
        rightSize, isPerfectRight := dfs(node.Right)
        if isPerfectLeft && isPerfectRight && leftSize == rightSize {
            size := leftSize + rightSize + 1
            sizes = append(sizes, size)
            return size, true
        }
        return 0, false
    }
    dfs(root)
    sort.Sort(sort.Reverse(sort.IntSlice(sizes)))
    if k-1 < len(sizes) {
        return sizes[k-1]
    }
    return -1
}