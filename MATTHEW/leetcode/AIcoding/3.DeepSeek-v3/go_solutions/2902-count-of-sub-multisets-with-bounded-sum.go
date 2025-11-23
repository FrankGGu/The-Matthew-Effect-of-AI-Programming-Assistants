func countSubMultisets(nums []int, l int, r int) int {
    const mod = 1e9 + 7
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    dp := make([]int, r+1)
    dp[0] = 1
    for num, cnt := range freq {
        for j := r; j >= 0; j-- {
            for k := 1; k <= cnt && j-k*num >= 0; k++ {
                dp[j] = (dp[j] + dp[j-k*num]) % mod
            }
        }
    }
    res := 0
    for i := l; i <= r; i++ {
        res = (res + dp[i]) % mod
    }
    return res
}