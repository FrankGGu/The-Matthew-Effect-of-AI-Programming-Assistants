func incremovableSubarrayCount(nums []int) int {
    n := len(nums)
    count := 0

    for i := 0; i < n; i++ {
        for j := i; j < n; j++ {
            // Construct the remaining array after removing nums[i...j]
            remaining := []int{}
            for k := 0; k < i; k++ {
                remaining = append(remaining, nums[k])
            }
            for k := j + 1; k < n; k++ {
                remaining = append(remaining, nums[k])
            }

            // Check if the remaining array is strictly increasing
            isStrictlyIncreasing := true
            if len(remaining) > 1 {
                for k := 0; k < len(remaining)-1; k++ {
                    if remaining[k] >= remaining[k+1] {
                        isStrictlyIncreasing = false
                        break
                    }
                }
            }

            if isStrictlyIncreasing {
                count++
            }
        }
    }
    return count
}