type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func countPalindromicPaths(root *TreeNode) int {
    return dfs(root, make(map[int]int), 0)
}

func dfs(node *TreeNode, count map[int]int, oddCount int) int {
    if node == nil {
        return 0
    }
    count[node.Val]++
    if count[node.Val]%2 == 0 {
        oddCount--
    } else {
        oddCount++
    }

    if node.Left == nil && node.Right == nil {
        if oddCount <= 1 {
            result := 1
            count[node.Val]--
            if count[node.Val]%2 == 0 {
                oddCount++
            } else {
                oddCount--
            }
            return result
        }
        count[node.Val]--
        return 0
    }

    result := dfs(node.Left, count, oddCount) + dfs(node.Right, count, oddCount)
    count[node.Val]--
    return result
}