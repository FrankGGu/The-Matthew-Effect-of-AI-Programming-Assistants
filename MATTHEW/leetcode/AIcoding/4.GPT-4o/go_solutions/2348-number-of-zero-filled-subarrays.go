func zeroFilledSubarray(nums []int) int64 {
    count, total := int64(0), int64(0)
    for _, num := range nums {
        if num == 0 {
            count++
            total += count
        } else {
            count = 0
        }
    }
    return total
}