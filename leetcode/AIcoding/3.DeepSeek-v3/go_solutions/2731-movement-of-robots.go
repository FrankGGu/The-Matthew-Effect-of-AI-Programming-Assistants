func sumDistance(nums []int, s string, d int) int {
    const mod = 1e9 + 7
    n := len(nums)
    pos := make([]int, n)
    for i := 0; i < n; i++ {
        if s[i] == 'L' {
            pos[i] = nums[i] - d
        } else {
            pos[i] = nums[i] + d
        }
    }
    sort.Ints(pos)
    res := 0
    prefix := 0
    for i := 0; i < n; i++ {
        res = (res + pos[i]*i - prefix) % mod
        prefix = (prefix + pos[i]) % mod
    }
    return res
}