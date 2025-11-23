func componentValue(nums []int, edges [][]int) int {
    n := len(nums)
    total := 0
    for _, num := range nums {
        total += num
    }

    adj := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        adj[u] = append(adj[u], v)
        adj[v] = append(adj[v], u)
    }

    maxK := 0
    for k := 1; k*k <= total; k++ {
        if total%k != 0 {
            continue
        }
        for _, d := range []int{k, total/k} {
            if d == total {
                continue
            }
            if d <= maxK {
                continue
            }
            if check(adj, nums, d) {
                maxK = d
            }
        }
    }
    return total/maxK - 1
}

func check(adj [][]int, nums []int, target int) bool {
    n := len(nums)
    visited := make([]bool, n)
    var dfs func(u int) int
    dfs = func(u int) int {
        visited[u] = true
        sum := nums[u]
        for _, v := range adj[u] {
            if visited[v] {
                continue
            }
            sum += dfs(v)
        }
        if sum == target {
            return 0
        }
        return sum
    }
    res := dfs(0)
    return res == 0
}