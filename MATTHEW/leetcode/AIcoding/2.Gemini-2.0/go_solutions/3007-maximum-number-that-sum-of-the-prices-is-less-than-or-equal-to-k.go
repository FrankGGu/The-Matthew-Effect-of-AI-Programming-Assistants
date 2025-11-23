func sumOfPrices(n int) int64 {
    res := int64(0)
    for i := 1; i <= n; i++ {
        if i&(i-1) == 0 {
            res++
        }
    }
    return res
}

func check(mid int, k int64) bool {
    s := sumOfPrices(mid)
    return int64(mid) - s <= k
}

func findMaximumNumber(k int64) int {
    l, r := 1, 1000000000000000000
    ans := 0
    for l <= r {
        mid := l + (r-l)/2
        if check(mid, k) {
            ans = mid
            l = mid + 1
        } else {
            r = mid - 1
        }
    }
    return ans
}