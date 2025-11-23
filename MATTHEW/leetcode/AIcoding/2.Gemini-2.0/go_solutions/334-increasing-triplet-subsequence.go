func increasingTriplet(nums []int) bool {
    if len(nums) < 3 {
        return false
    }
    first := int(^uint(0) >> 1)
    second := int(^uint(0) >> 1)
    for _, num := range nums {
        if num <= first {
            first = num
        } else if num <= second {
            second = num
        } else {
            return true
        }
    }
    return false
}