type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func minCost(root *TreeNode) int {
    if root == nil {
        return 0
    }
    return dfs(root, make(map[int]int))
}

func dfs(node *TreeNode, costMap map[int]int) int {
    if node == nil {
        return 0
    }
    costMap[node.Val]++
    leftCost := dfs(node.Left, costMap)
    rightCost := dfs(node.Right, costMap)

    if leftCost == 0 && rightCost == 0 {
        return costMap[node.Val]
    }

    minCost := int(1e9)
    total := leftCost + rightCost + costMap[node.Val]

    for key := range costMap {
        if key != node.Val {
            minCost = min(minCost, total - costMap[key] + 1)
        }
    }

    return minCost
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}