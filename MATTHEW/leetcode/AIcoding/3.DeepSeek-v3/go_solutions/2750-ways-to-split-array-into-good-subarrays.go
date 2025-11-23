func numberOfGoodSubarraySplits(nums []int) int {
    const mod = 1e9 + 7
    n := len(nums)
    ones := []int{}
    for i, num := range nums {
        if num == 1 {
            ones = append(ones, i)
        }
    }
    if len(ones) == 0 {
        return 0
    }
    res := 1
    for i := 1; i < len(ones); i++ {
        diff := ones[i] - ones[i-1]
        res = (res * diff) % mod
    }
    return res
}