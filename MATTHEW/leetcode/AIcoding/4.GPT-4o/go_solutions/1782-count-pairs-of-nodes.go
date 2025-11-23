type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func countPairs(root *TreeNode, distance int) int {
    if root == nil {
        return 0
    }
    var count int
    var dfs func(node *TreeNode) []int
    dfs = func(node *TreeNode) []int {
        if node == nil {
            return []int{}
        }
        leftDistances := dfs(node.Left)
        rightDistances := dfs(node.Right)

        for _, d1 := range leftDistances {
            for _, d2 := range rightDistances {
                if d1+d2+2 <= distance {
                    count++
                }
            }
        }

        currentDistances := make([]int, 0)
        for _, d := range leftDistances {
            if d+1 < distance {
                currentDistances = append(currentDistances, d+1)
            }
        }
        for _, d := range rightDistances {
            if d+1 < distance {
                currentDistances = append(currentDistances, d+1)
            }
        }
        return currentDistances
    }
    dfs(root)
    return count
}