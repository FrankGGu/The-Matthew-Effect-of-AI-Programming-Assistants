import "sort"

func checkWays(pairs [][]int) int {
    graph := make(map[int][]int)
    indegree := make(map[int]int)

    for _, pair := range pairs {
        graph[pair[0]] = append(graph[pair[0]], pair[1])
        indegree[pair[1]]++
    }

    roots := []int{}
    for k := range graph {
        if indegree[k] == 0 {
            roots = append(roots, k)
        }
    }

    if len(roots) != 1 {
        return 0
    }

    var dfs func(node int) (int, bool)
    dfs = func(node int) (int, bool) {
        children := graph[node]
        sort.Ints(children)

        totalWays := 1
        for _, child := range children {
            ways, valid := dfs(child)
            if !valid {
                return 0, false
            }
            totalWays *= ways
        }

        return totalWays, true
    }

    ways, valid := dfs(roots[0])
    if !valid {
        return 0
    }

    return ways
}