func waysToSplitArray(nums []int) int {
    total := 0
    sum := 0
    for _, num := range nums {
        total += num
    }
    count := 0
    for i := 0; i < len(nums)-1; i++ {
        sum += nums[i]
        if sum >= total-sum {
            count++
        }
    }
    return count
}