func minSubsequence(nums []int) []int {
    totalSum := 0
    for _, num := range nums {
        totalSum += num
    }

    sort.Slice(nums, func(i, j int) bool {
        return nums[i] > nums[j]
    })

    subsequenceSum := 0
    result := []int{}

    for _, num := range nums {
        subsequenceSum += num
        result = append(result, num)
        if subsequenceSum > totalSum-subsequenceSum {
            break
        }
    }

    return result
}