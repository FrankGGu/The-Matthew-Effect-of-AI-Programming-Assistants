func maximizeScore(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    left := make([]int, n)  // Stores index of the first element to the left that is strictly smaller than nums[i]
    right := make([]int, n) // Stores index of the first element to the right that is strictly smaller than nums[i]

    stack := []int{} // Monotonic increasing stack for finding left smaller
    for i := 0; i < n; i++ {
        for len(stack) > 0 && nums[stack[len(stack)-1]] >= nums[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            left[i] = -1
        } else {
            left[i] = stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    // Clear and reuse stack for finding right smaller
    stack = []int{} 
    for i := n - 1; i >= 0; i-- {
        for len(stack) > 0 && nums[stack[len(stack)-1]] >= nums[i] {
            stack = stack[:len(stack)-1]
        }
        if len(stack) == 0 {
            right[i] = n
        } else {
            right[i] = stack[len(stack)-1]
        }
        stack = append(stack, i)
    }

    maxScore := 0
    for i := 0; i < n; i++ {
        // For each nums[i], it is the minimum element in the subarray from (left[i]+1) to (right[i]-1).
        // The length of this subarray is (right[i] - 1) - (left[i] + 1) + 1 = right[i] - left[i] - 1.
        score := nums[i] * (right[i] - left[i] - 1)
        if score > maxScore {
            maxScore = score
        }
    }

    return maxScore
}