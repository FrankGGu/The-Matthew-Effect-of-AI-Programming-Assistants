func canPartitionKSubsets(nums []int, k int) bool {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    if sum % k != 0 {
        return false
    }
    target := sum / k
    used := make([]bool, len(nums))
    sort.Slice(nums, func(i, j int) bool {
        return nums[i] > nums[j]
    })

    var backtrack func(int, int, int) bool
    backtrack = func(start, currentSum, groupsDone int) bool {
        if groupsDone == k {
            return true
        }
        if currentSum == target {
            return backtrack(0, 0, groupsDone + 1)
        }
        for i := start; i < len(nums); i++ {
            if used[i] || currentSum + nums[i] > target {
                continue
            }
            used[i] = true
            if backtrack(i + 1, currentSum + nums[i], groupsDone) {
                return true
            }
            used[i] = false
            if currentSum == 0 {
                break
            }
        }
        return false
    }

    return backtrack(0, 0, 0)
}