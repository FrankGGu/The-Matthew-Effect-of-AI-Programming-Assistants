func findRadius(houses []int, heaters []int) int {
    sort.Ints(heaters)
    radius := 0

    for _, house := range houses {
        left, right := 0, len(heaters)-1
        for left < right {
            mid := left + (right-left)/2
            if heaters[mid] < house {
                left = mid + 1
            } else {
                right = mid
            }
        }

        dist := math.MaxInt32
        if left < len(heaters) {
            dist = abs(house - heaters[left])
        }
        if left > 0 {
            dist = min(dist, abs(house - heaters[left-1]))
        }
        radius = max(radius, dist)
    }

    return radius
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}