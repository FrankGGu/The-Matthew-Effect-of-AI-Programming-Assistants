func minimumFuelCost(roads [][]int, seats int) int64 {
    graph := make([][]int, len(roads)+1)
    for _, road := range roads {
        graph[road[0]] = append(graph[road[0]], road[1])
        graph[road[1]] = append(graph[road[1]], road[0])
    }

    var dfs func(node, parent int) (int64, int64)
    dfs = func(node, parent int) (int64, int64) {
        totalPeople, totalFuel := int64(1), int64(0)
        for _, neighbor := range graph[node] {
            if neighbor != parent {
                people, fuel := dfs(neighbor, node)
                totalPeople += people
                totalFuel += fuel
            }
        }
        if node != 0 {
            totalFuel += (totalPeople + int64(seats) - 1) / int64(seats)
        }
        return totalPeople, totalFuel
    }

    _, fuelCost := dfs(0, -1)
    return fuelCost
}