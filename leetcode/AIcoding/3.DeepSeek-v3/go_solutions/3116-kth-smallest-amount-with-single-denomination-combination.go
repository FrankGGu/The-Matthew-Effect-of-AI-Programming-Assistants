func findKthSmallest(coins []int, k int) int64 {
    left, right := int64(1), int64(1e18)
    for left < right {
        mid := left + (right-left)/2
        if count(coins, mid) >= k {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func count(coins []int, limit int64) int64 {
    n := len(coins)
    var total int64 = 0
    for mask := 1; mask < (1 << n); mask++ {
        bits, lcm := 0, int64(1)
        for i := 0; i < n; i++ {
            if mask&(1<<i) != 0 {
                bits++
                lcm = lcm * int64(coins[i]) / gcd(lcm, int64(coins[i]))
            }
        }
        if bits%2 == 1 {
            total += limit / lcm
        } else {
            total -= limit / lcm
        }
    }
    return total
}

func gcd(a, b int64) int64 {
    for b != 0 {
        a, b = b, a%b
    }
    return a
}