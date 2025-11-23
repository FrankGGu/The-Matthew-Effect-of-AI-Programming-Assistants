func sumOfSquares(nums []int) int {
    n := len(nums)
    if n == 0 {
        return 0
    }

    result := 0
    for i := 0; i < n; i++ {
        seen := map[int]bool{}
        sum := 0
        for j := i; j < n; j++ {
            if !seen[nums[j]] {
                seen[nums[j]] = true
                sum += nums[j] * nums[j]
            }
            result += sum
        }
    }

    return result
}