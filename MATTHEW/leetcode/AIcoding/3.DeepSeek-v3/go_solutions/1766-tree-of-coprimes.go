func getCoprimes(nums []int, edges [][]int) []int {
    n := len(nums)
    graph := make([][]int, n)
    for _, edge := range edges {
        u, v := edge[0], edge[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    coprimes := make(map[int][]int)
    for i := 1; i <= 50; i++ {
        for j := 1; j <= 50; j++ {
            if gcd(i, j) == 1 {
                coprimes[i] = append(coprimes[i], j)
            }
        }
    }

    res := make([]int, n)
    stack := make([][2]int, 0)
    visited := make([]bool, n)
    ancestors := make(map[int][][2]int)

    var dfs func(int)
    dfs = func(u int) {
        visited[u] = true
        num := nums[u]
        maxDepth := -1
        res[u] = -1

        for _, coprime := range coprimes[num] {
            if len(ancestors[coprime]) > 0 {
                last := ancestors[coprime][len(ancestors[coprime])-1]
                if last[1] > maxDepth {
                    maxDepth = last[1]
                    res[u] = last[0]
                }
            }
        }

        ancestors[num] = append(ancestors[num], [2]int{u, len(stack)})
        stack = append(stack, [2]int{u, num})

        for _, v := range graph[u] {
            if !visited[v] {
                dfs(v)
            }
        }

        ancestors[num] = ancestors[num][:len(ancestors[num])-1]
        stack = stack[:len(stack)-1]
    }

    dfs(0)
    return res
}

func gcd(a, b int) int {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}