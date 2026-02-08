func minOperations(nums []int) int {
    n := len(nums)
    if n <= 1 {
        return 0
    }

    diff := nums[1] - nums[0]
    operations := 0

    for i := 2; i < n; i++ {
        currentDiff := nums[i] - nums[i-1]
        if currentDiff != diff {
            if i < n-1 {
                nextDiff := nums[i+1] - nums[i]
                if currentDiff + nextDiff == 2 * diff {
                    operations++
                    nums[i] = nums[i-1] + diff
                    i++
                } else {
                    operations++
                    nums[i] = nums[i-1] + diff
                }
            } else {
                operations++
                nums[i] = nums[i-1] + diff
            }
        }
    }

    return operations
}