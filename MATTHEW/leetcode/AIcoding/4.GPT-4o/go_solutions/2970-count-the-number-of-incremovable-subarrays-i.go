func countSubarrays(nums []int) int {
    n := len(nums)
    left := make([]int, n)
    right := make([]int, n)

    for i := 0; i < n; i++ {
        if i == 0 || nums[i] > nums[i-1] {
            left[i] = 1
        } else {
            left[i] = left[i-1] + 1
        }
    }

    for i := n - 1; i >= 0; i-- {
        if i == n-1 || nums[i] < nums[i+1] {
            right[i] = 1
        } else {
            right[i] = right[i+1] + 1
        }
    }

    total := 0
    for i := 0; i < n; i++ {
        total += left[i] + right[i] - 1
    }

    return total
}