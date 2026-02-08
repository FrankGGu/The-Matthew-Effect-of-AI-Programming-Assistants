package main

func minimumFuelCost(roads [][]int, seats int) int {
    graph := make([][]int, len(roads)+1)
    for _, road := range roads {
        u, v := road[0], road[1]
        graph[u] = append(graph[u], v)
        graph[v] = append(graph[v], u)
    }

    var result int

    var dfs func(node, parent int) int
    dfs = func(node, parent int) int {
        totalPeople := 1
        for _, neighbor := range graph[node] {
            if neighbor == parent {
                continue
            }
            people := dfs(neighbor, node)
            totalPeople += people
            if seats > 0 {
                result += (people + seats - 1) / seats
            }
        }
        return totalPeople
    }

    dfs(0, -1)
    return result
}