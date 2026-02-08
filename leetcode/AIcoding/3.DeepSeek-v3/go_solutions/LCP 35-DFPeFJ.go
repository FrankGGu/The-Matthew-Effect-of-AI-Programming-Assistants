func maxPower(stations []int, r int, k int) int64 {
    n := len(stations)
    prefix := make([]int64, n+1)
    for i := 0; i < n; i++ {
        left := max(0, i - r)
        right := min(n - 1, i + r)
        prefix[left] += int64(stations[i])
        if right + 1 < n {
            prefix[right + 1] -= int64(stations[i])
        }
    }

    current := int64(0)
    minPower := int64(math.MaxInt64)
    for i := 0; i < n; i++ {
        current += prefix[i]
        if current < minPower {
            minPower = current
        }
    }

    low := minPower
    high := minPower + int64(k)

    var answer int64
    for low <= high {
        mid := (low + high) / 2
        if check(prefix, mid, int64(k), int64(r), int64(n)) {
            answer = mid
            low = mid + 1
        } else {
            high = mid - 1
        }
    }
    return answer
}

func check(prefix []int64, minPower int64, k int64, r int64, n int64) bool {
    diff := make([]int64, n + 2)
    current := int64(0)
    used := int64(0)
    for i := int64(0); i < n; i++ {
        current += prefix[i] + diff[i]
        if current < minPower {
            delta := minPower - current
            if used + delta > k {
                return false
            }
            used += delta
            right := min(n - 1, i + r)
            diff[i] += delta
            diff[right + 1] -= delta
            current += delta
        }
    }
    return true
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}