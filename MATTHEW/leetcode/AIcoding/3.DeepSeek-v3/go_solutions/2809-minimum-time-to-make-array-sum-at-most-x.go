func minimumTime(nums1 []int, nums2 []int, x int) int {
    n := len(nums1)
    type pair struct {
        a, b int
    }
    pairs := make([]pair, n)
    for i := 0; i < n; i++ {
        pairs[i] = pair{nums1[i], nums2[i]}
    }
    sort.Slice(pairs, func(i, j int) bool {
        return pairs[i].b < pairs[j].b
    })

    dp := make([]int, n+1)
    for i := 0; i < n; i++ {
        a, b := pairs[i].a, pairs[i].b
        for j := i + 1; j > 0; j-- {
            if dp[j-1]+a+b*j > dp[j] {
                dp[j] = dp[j-1] + a + b*j
            }
        }
    }

    sum1, sum2 := 0, 0
    for i := 0; i < n; i++ {
        sum1 += nums1[i]
        sum2 += nums2[i]
    }

    for t := 0; t <= n; t++ {
        if sum1 + sum2 * t - dp[t] <= x {
            return t
        }
    }
    return -1
}