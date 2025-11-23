func smallestSubarrays(nums []int) []int {
    n := len(nums)
    result := make([]int, n)
    maxOr := make([]int, n)

    for i := 0; i < n; i++ {
        maxOr[i] = nums[i]
    }

    for i := n - 1; i >= 0; i-- {
        currentOr := 0
        for j := i; j < n; j++ {
            currentOr |= nums[j]
            if currentOr == maxOr[i] {
                result[i] = j - i + 1
                break
            }
        }
    }

    return result
}