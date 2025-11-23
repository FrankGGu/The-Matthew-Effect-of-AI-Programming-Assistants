type TreeNode struct {
    Val   int
    Left  *TreeNode
    Right *TreeNode
}

func sumOfDistancesInTree(n int, edges [][]int) []int {
    graph := make([][]int, n)
    for _, edge := range edges {
        graph[edge[0]] = append(graph[edge[0]], edge[1])
        graph[edge[1]] = append(graph[edge[1]], edge[0])
    }

    count := make([]int, n)
    ans := make([]int, n)
    var dfs func(node, parent int)
    dfs = func(node, parent int) {
        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            dfs(neighbor, node)
            count[node] += count[neighbor] + 1
            ans[node] += ans[neighbor] + count[neighbor] + 1
        }
    }

    dfs(0, -1)

    var dfs2 func(node, parent int)
    dfs2 = func(node, parent int) {
        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            ans[neighbor] = ans[node] - (count[neighbor] + 1) + (n - (count[neighbor] + 1))
            dfs2(neighbor, node)
        }
    }

    dfs2(0, -1)
    return ans
}