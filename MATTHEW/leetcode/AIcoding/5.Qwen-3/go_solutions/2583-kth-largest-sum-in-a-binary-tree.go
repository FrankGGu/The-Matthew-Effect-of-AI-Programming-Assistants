package main


func kthLargestLevelSum(root *TreeNode, k int) int {
    if root == nil {
        return -1
    }

    var levels []*TreeNode
    levels = append(levels, root)

    var sums []int

    for len(levels) > 0 {
        levelSize := len(levels)
        sum := 0
        for i := 0; i < levelSize; i++ {
            node := levels[0]
            levels = levels[1:]
            sum += node.Val
            if node.Left != nil {
                levels = append(levels, node.Left)
            }
            if node.Right != nil {
                levels = append(levels, node.Right)
            }
        }
        sums = append(sums, sum)
    }

    if k > len(sums) {
        return -1
    }

    sort.Ints(sums)
    return sums[len(sums)-k]
}