func distanceBetweenBusStops(distance []int, start int, destination int) int {
    if start == destination {
        return 0
    }
    if start > destination {
        start, destination = destination, start
    }
    total, sum := 0, 0
    for i := 0; i < len(distance); i++ {
        total += distance[i]
        if i >= start && i < destination {
            sum += distance[i]
        }
    }
    if sum < total-sum {
        return sum
    }
    return total - sum
}