package main


func countNodes(root *TreeNode, res []int) int {
    if root == nil {
        return 0
    }
    left := countNodes(root.Left, res)
    right := countNodes(root.Right, res)
    total := left + right + 1
    res[root.Val] += total
    return total
}

func countSubTrees(n int, s string, edges [][]int) []int {
    tree := make([]*TreeNode, n)
    for i := range tree {
        tree[i] = &TreeNode{}
    }
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        if tree[u].Left == nil {
            tree[u].Left = tree[v]
        } else {
            tree[u].Right = tree[v]
        }
    }
    res := make([]int, n)
    countNodes(tree[0], res)
    return res
}