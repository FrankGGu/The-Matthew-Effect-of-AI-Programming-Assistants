func sumOfPower(nums []int) int {
    const mod = 1e9 + 7
    sort.Ints(nums)
    res, preSum := 0, 0
    for _, num := range nums {
        res = (res + (num*num % mod) * num % mod) % mod
        res = (res + (num*num % mod) * preSum % mod) % mod
        preSum = (preSum*2 + num) % mod
    }
    return res
}