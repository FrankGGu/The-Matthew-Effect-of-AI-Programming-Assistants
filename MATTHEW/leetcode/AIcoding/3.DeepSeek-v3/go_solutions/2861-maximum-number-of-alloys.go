func maxNumberOfAlloys(n int, k int, budget int, composition [][]int, stock []int, cost []int) int {
    maxAlloys := 0
    left, right := 0, int(2e8)

    for _, comp := range composition {
        l, r := 0, right
        best := 0
        for l <= r {
            mid := (l + r) / 2
            totalCost := 0
            possible := true
            for i := 0; i < n; i++ {
                needed := comp[i] * mid
                if needed > stock[i] {
                    totalCost += (needed - stock[i]) * cost[i]
                    if totalCost > budget {
                        possible = false
                        break
                    }
                }
            }
            if possible {
                best = mid
                l = mid + 1
            } else {
                r = mid - 1
            }
        }
        if best > maxAlloys {
            maxAlloys = best
        }
    }
    return maxAlloys
}