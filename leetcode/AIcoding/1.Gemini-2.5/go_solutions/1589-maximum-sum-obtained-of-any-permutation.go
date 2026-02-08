func maxSumRangeQuery(nums []int, requests [][]int) int {
    const mod = 1e9 + 7
    n := len(nums)
    count := make([]int, n+1)

    for _, req := range requests {
        l, r := req[0], req[1]
        count[l]++
        if r+1 < n {
            count[r+1]--
        }
    }

    for i := 1; i < n; i++ {
        count[i] += count[i-1]
    }

    sort.Ints(nums)
    sort.Ints(count[:n])

    res := 0
    for i := 0; i < n; i++ {
        res = (res + nums[i]*count[i]) % mod
    }

    return res
}