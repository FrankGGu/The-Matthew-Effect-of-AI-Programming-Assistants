package main

func maxScore(nums []int, edges [][]int) int {
    n := len(nums)
    graph := make([][]int, n)
    for _, e := range edges {
        u, v := e[0], e[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    var dfs func(int, int) []int
    dfs = func(node, parent int) []int {
        res := []int{nums[node]}
        for _, child := range graph[node] {
            if child != parent {
                childRes := dfs(child, node)
                for _, val := range childRes {
                    res = append(res, val)
                }
            }
        }
        return res
    }

    maxScore := 0
    for i := 0; i < n; i++ {
        for j := i + 1; j < n; j++ {
            if i == j {
                continue
            }
            a, b := i, j
            visited := make(map[int]bool)
            queue := []int{a}
            visited[a] = true
            countA := 0
            for len(queue) > 0 {
                node := queue[0]
                queue = queue[1:]
                countA++
                for _, neighbor := range graph[node] {
                    if !visited[neighbor] {
                        visited[neighbor] = true
                        queue = append(queue, neighbor)
                    }
                }
            }

            visited = make(map[int]bool)
            queue = []int{b}
            visited[b] = true
            countB := 0
            for len(queue) > 0 {
                node := queue[0]
                queue = queue[1:]
                countB++
                for _, neighbor := range graph[node] {
                    if !visited[neighbor] {
                        visited[neighbor] = true
                        queue = append(queue, neighbor)
                    }
                }
            }

            score := (countA * nums[i]) + (countB * nums[j])
            if score > maxScore {
                maxScore = score
            }
        }
    }

    return maxScore
}