func maxPower(stations []int, r int, k int) int64 {
    n := len(stations)
    prefixSum := make([]int64, n+1)
    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i] + int64(stations[i])
    }

    check := func(power int64) bool {
        need := 0
        add := make([]int64, n)
        cur := int64(0)
        for i := 0; i < n; i++ {
            cur += add[i]
            currPower := prefixSum[min(n, i+r+1)] - prefixSum[max(0, i-r)] + cur
            if currPower < power {
                diff := power - currPower
                need += int(diff)
                if need > k {
                    return false
                }
                cur += diff
                if i+2*r+1 < n {
                    add[i+2*r+1] = -diff
                }
            }
        }
        return true
    }

    left, right := int64(0), int64(0)
    for _, s := range stations {
        right += int64(s)
    }
    right += int64(k)

    ans := int64(0)
    for left <= right {
        mid := left + (right-left)/2
        if check(mid) {
            ans = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    return ans
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