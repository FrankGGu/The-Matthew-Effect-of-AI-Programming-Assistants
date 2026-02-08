func partitionArray(nums []int, k int) int {
    if len(nums) == 0 {
        return 0
    }
    sort.Ints(nums)
    count := 1
    minVal := nums[0]

    for _, num := range nums {
        if num-minVal > k {
            count++
            minVal = num
        }
    }

    return count
}