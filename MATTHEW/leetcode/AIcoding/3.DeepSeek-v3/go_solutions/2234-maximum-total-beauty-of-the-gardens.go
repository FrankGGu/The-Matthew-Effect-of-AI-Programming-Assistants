func maximumBeauty(flowers []int, newFlowers int64, target int, full int, partial int) int64 {
    sort.Ints(flowers)
    n := len(flowers)
    prefix := make([]int64, n+1)
    for i := 0; i < n; i++ {
        prefix[i+1] = prefix[i] + int64(flowers[i])
    }

    res := int64(0)
    for k := 0; k <= n; k++ {
        if k > 0 {
            need := int64(max(0, target - flowers[n-k]))
            if newFlowers < need {
                break
            }
            newFlowers -= need
        }

        if k == n {
            res = max64(res, int64(full)*int64(k))
            continue
        }

        low, high := flowers[0], target-1
        best := 0
        for low <= high {
            mid := (low + high) / 2
            pos := sort.Search(n-k, func(i int) bool { return flowers[i] >= mid })
            total := int64(mid)*int64(pos) - prefix[pos]
            if total <= newFlowers {
                best = mid
                low = mid + 1
            } else {
                high = mid - 1
            }
        }

        current := int64(full)*int64(k) + int64(partial)*int64(best)
        res = max64(res, current)
    }
    return res
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func max64(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}