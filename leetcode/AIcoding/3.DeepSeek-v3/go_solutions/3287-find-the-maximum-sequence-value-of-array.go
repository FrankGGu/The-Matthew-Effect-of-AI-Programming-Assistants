func maxSequenceValue(nums []int) int64 {
    max1, max2 := -1, -1
    for _, num := range nums {
        if num > max1 {
            max2 = max1
            max1 = num
        } else if num > max2 {
            max2 = num
        }
    }
    if max2 == -1 {
        return int64(max1 * max1)
    }
    return int64(max1 * max2)
}