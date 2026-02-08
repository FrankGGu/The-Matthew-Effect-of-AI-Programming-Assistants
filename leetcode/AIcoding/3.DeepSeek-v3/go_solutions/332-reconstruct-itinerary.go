func findItinerary(tickets [][]string) []string {
    graph := make(map[string][]string)
    for _, ticket := range tickets {
        from, to := ticket[0], ticket[1]
        graph[from] = append(graph[from], to)
    }
    for key := range graph {
        sort.Sort(sort.Reverse(sort.StringSlice(graph[key])))
    }
    var itinerary []string
    var dfs func(node string)
    dfs = func(node string) {
        for len(graph[node]) > 0 {
            next := graph[node][len(graph[node])-1]
            graph[node] = graph[node][:len(graph[node])-1]
            dfs(next)
        }
        itinerary = append(itinerary, node)
    }
    dfs("JFK")
    for i, j := 0, len(itinerary)-1; i < j; i, j = i+1, j-1 {
        itinerary[i], itinerary[j] = itinerary[j], itinerary[i]
    }
    return itinerary
}