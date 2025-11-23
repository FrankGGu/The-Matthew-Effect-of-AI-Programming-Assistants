func thirdMax(nums []int) int {
    max1, max2, max3 := math.MinInt64, math.MinInt64, math.MinInt64
    for _, num := range nums {
        if num == max1 || num == max2 || num == max3 {
            continue
        }
        if num > max1 {
            max3, max2, max1 = max2, max1, num
        } else if num > max2 {
            max3, max2 = max2, num
        } else if num > max3 {
            max3 = num
        }
    }
    if max3 != math.MinInt64 {
        return max3
    }
    return max1
}