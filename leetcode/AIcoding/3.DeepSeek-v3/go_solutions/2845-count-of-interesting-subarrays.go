func countInterestingSubarrays(nums []int, modulo int, k int) int64 {
    prefix := make(map[int]int)
    prefix[0] = 1
    res := 0
    sum := 0
    for _, num := range nums {
        if num % modulo == k {
            sum++
        }
        sum %= modulo
        res += prefix[(sum - k + modulo) % modulo]
        prefix[sum]++
    }
    return int64(res)
}