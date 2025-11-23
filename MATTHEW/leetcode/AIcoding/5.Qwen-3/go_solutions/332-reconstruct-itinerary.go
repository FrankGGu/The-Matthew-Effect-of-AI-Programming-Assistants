package main

func findItinerary(tickets [][]string) []string {
    graph := make(map[string][]string)
    for _, ticket := range tickets {
        src, dest := ticket[0], ticket[1]
        graph[src] = append(graph[src], dest)
    }

    for key := range graph {
        sort.Strings(graph[key])
    }

    result := []string{}
    var dfs func(string)
    dfs = func(node string) {
        for len(graph[node]) > 0 {
            next := graph[node][0]
            graph[node] = graph[node][1:]
            dfs(next)
        }
        result = append(result, node)
    }

    dfs("JFK")

    for i, j := 0, len(result)-1; i < j; i, j = i+1, j-1 {
        result[i], result[j] = result[j], result[i]
    }

    return result
}