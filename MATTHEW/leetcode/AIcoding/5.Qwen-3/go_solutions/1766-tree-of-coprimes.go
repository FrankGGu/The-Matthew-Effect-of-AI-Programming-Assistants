package main


func getCoprimesOfTree(root *TreeNode) []int {
    var result []int
    parent := make(map[int]int)
    depth := make(map[int]int)
    gcdMap := make(map[int][]int)

    for i := 1; i <= 1000; i++ {
        for j := 1; j <= 1000; j++ {
            if gcd(i, j) == 1 {
                gcdMap[i] = append(gcdMap[i], j)
            }
        }
    }

    var dfs func(node *TreeNode, d int, p int)
    dfs = func(node *TreeNode, d int, p int) {
        if node == nil {
            return
        }
        parent[node.Val] = p
        depth[node.Val] = d
        for _, v := range gcdMap[node.Val] {
            if v != node.Val && parent[v] != 0 {
                result = append(result, v)
                break
            }
        }
        dfs(node.Left, d+1, node.Val)
        dfs(node.Right, d+1, node.Val)
    }

    dfs(root, 0, -1)

    return result
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}