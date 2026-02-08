import "math"

type Flight struct {
    city, cost, stops int
}

func findCheapestPrice(n int, flights [][]int, src int, dst int, K int) int {
    graph := make([][]Flight, n)
    for _, flight := range flights {
        graph[flight[0]] = append(graph[flight[0]], Flight{flight[1], flight[2], 0})
    }

    pq := make([]Flight, 0)
    pq = append(pq, Flight{src, 0, 0})
    minCost := make([][]int, n)
    for i := range minCost {
        minCost[i] = make([]int, K+2)
        for j := range minCost[i] {
            minCost[i][j] = math.MaxInt32
        }
    }
    minCost[src][0] = 0

    for len(pq) > 0 {
        current := pq[0]
        pq = pq[1:]

        if current.city == dst {
            return current.cost
        }

        if current.stops == K+1 {
            continue
        }

        for _, flight := range graph[current.city] {
            nextCost := current.cost + flight.cost
            nextStops := current.stops + 1
            if nextCost < minCost[flight.city][nextStops] {
                minCost[flight.city][nextStops] = nextCost
                pq = append(pq, Flight{flight.city, nextCost, nextStops})
            }
        }
    }

    result := math.MaxInt32
    for i := 1; i <= K+1; i++ {
        result = min(result, minCost[dst][i])
    }

    if result == math.MaxInt32 {
        return -1
    }
    return result
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}