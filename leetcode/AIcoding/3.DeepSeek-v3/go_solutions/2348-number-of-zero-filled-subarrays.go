func zeroFilledSubarray(nums []int) int64 {
    var res, count int64
    for _, num := range nums {
        if num == 0 {
            count++
            res += count
        } else {
            count = 0
        }
    }
    return res
}