type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func mostProfitablePath(root *TreeNode, start int, amount []int) []int {
    maxProfit := -1
    var bestPath []int

    var dfs func(node *TreeNode, path []int, currentProfit int)
    dfs = func(node *TreeNode, path []int, currentProfit int) {
        if node == nil {
            return
        }
        currentProfit += amount[node.Val]
        path = append(path, node.Val)

        if node.Left == nil && node.Right == nil {
            if currentProfit > maxProfit {
                maxProfit = currentProfit
                bestPath = append([]int{}, path...)
            }
        } else {
            dfs(node.Left, path, currentProfit)
            dfs(node.Right, path, currentProfit)
        }
        path = path[:len(path)-1]
    }

    var startNode *TreeNode
    var findStart func(node *TreeNode)
    findStart = func(node *TreeNode) {
        if node == nil {
            return
        }
        if node.Val == start {
            startNode = node
        }
        findStart(node.Left)
        findStart(node.Right)
    }

    findStart(root)
    dfs(startNode, []int{}, 0)
    return bestPath
}