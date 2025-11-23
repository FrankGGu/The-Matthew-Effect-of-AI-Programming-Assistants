package main

func waysToReconstructTree(n int, edges [][]int) int {
    if n == 1 {
        return 1
    }
    parent := make(map[int]int)
    children := make(map[int][]int)
    degree := make(map[int]int)

    for _, edge := range edges {
        u, v := edge[0], edge[1]
        degree[u]++
        degree[v]++
        if degree[u] == 1 {
            children[u] = append(children[u], v)
        } else {
            children[v] = append(children[v], u)
        }
    }

    var root int
    for k, v := range degree {
        if v == 1 {
            root = k
            break
        }
    }

    var dfs func(int, int) int
    dfs = func(u, p int) int {
        res := 1
        for _, v := range children[u] {
            if v != p {
                res *= dfs(v, u)
            }
        }
        return res
    }

    return dfs(root, -1)
}