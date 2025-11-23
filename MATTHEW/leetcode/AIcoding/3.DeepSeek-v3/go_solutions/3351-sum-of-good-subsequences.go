func sumOfPower(nums []int) int {
    const mod = 1e9 + 7
    sort.Ints(nums)
    res, prev := 0, 0
    for _, num := range nums {
        current := (prev + num) % mod
        res = (res + (num * num % mod) * current % mod) % mod
        prev = (current + prev) % mod
    }
    return res
}