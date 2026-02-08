package main

type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func kthLargestPerfectSubtreeSize(root *TreeNode, k int) int {
    sizes := []int{}
    var dfs func(*TreeNode) int
    dfs = func(node *TreeNode) int {
        if node == nil {
            return 0
        }
        left := dfs(node.Left)
        right := dfs(node.Right)
        if left == right && left != -1 {
            sizes = append(sizes, left+1)
            return left + 1
        }
        return -1
    }
    dfs(root)
    if len(sizes) < k {
        return -1
    }
    sort.Ints(sizes)
    return sizes[len(sizes)-k]
}