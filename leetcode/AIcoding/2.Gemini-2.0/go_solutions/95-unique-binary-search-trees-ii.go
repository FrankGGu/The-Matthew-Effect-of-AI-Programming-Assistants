func generateTrees(n int) []*TreeNode {
    if n == 0 {
        return []*TreeNode{}
    }
    return generate(1, n)
}

func generate(start, end int) []*TreeNode {
    if start > end {
        return []*TreeNode{nil}
    }

    trees := []*TreeNode{}
    for i := start; i <= end; i++ {
        leftTrees := generate(start, i-1)
        rightTrees := generate(i+1, end)

        for _, left := range leftTrees {
            for _, right := range rightTrees {
                root := &TreeNode{Val: i}
                root.Left = left
                root.Right = right
                trees = append(trees, root)
            }
        }
    }
    return trees
}