func isIdealPermutation(nums []int) bool {
    n := len(nums)
    if n <= 2 {
        return true
    }

    // minSuffix[i] stores the minimum value in nums[i:]
    minSuffix := make([]int, n)
    minSuffix[n-1] = nums[