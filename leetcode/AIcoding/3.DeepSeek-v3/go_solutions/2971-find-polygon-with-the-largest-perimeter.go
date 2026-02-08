func largestPerimeter(nums []int) int64 {
    sort.Ints(nums)
    var sum int64 = 0
    for _, num := range nums {
        sum += int64(num)
    }
    for i := len(nums) - 1; i >= 2; i-- {
        sum -= int64(nums[i])
        if sum > int64(nums[i]) {
            return sum + int64(nums[i])
        }
    }
    return -1
}