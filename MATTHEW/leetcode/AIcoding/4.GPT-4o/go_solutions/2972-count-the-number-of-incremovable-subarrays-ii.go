func countIncremovableSubarrays(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    left := make([]int, n)
    right := make([]int, n)

    left[0] = 1
    for i := 1; i < n; i++ {
        if nums[i] > nums[i-1] {
            left[i] = left[i-1] + 1
        } else {
            left[i] = 1
        }
    }

    right[n-1] = 1
    for i := n - 2; i >= 0; i-- {
        if nums[i] < nums[i+1] {
            right[i] = right[i+1] + 1
        } else {
            right[i] = 1
        }
    }

    total := 0
    for i := 0; i < n; i++ {
        total += left[i] + right[i] - 1
    }

    return total
}