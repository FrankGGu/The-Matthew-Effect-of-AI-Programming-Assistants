func maxPower(stations []int, r int, k int) int64 {
    n := len(stations)
    power := make([]int64, n)
    for i := 0; i < n; i++ {
        left := max(0, i - r)
        right := min(n - 1, i + r)
        for j := left; j <= right; j++ {
            power[i] += int64(stations[j])
        }
    }

    left := int64(0)
    right := int64(1 << 60)
    var res int64

    for left <= right {
        mid := left + (right - left) / 2
        if canAchieve(power, r, k, mid) {
            res = mid
            left = mid + 1
        } else {
            right = mid - 1
        }
    }

    return res
}

func canAchieve(power []int64, r int, k int, target int64) bool {
    n := len(power)
    diff := make([]int64, n + 1)
    var current, need int64

    for i := 0; i < n; i++ {
        current += diff[i]
        if power[i] + current < target {
            delta := target - (power[i] + current)
            need += delta
            if need > int64(k) {
                return false
            }
            current += delta
            right := min(n - 1, i + r)
            if right + 1 < n {
                diff[right + 1] -= delta
            }
        }
    }

    return need <= int64(k)
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