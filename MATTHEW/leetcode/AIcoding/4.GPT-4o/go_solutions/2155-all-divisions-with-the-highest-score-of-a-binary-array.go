func maxScoreIndices(nums []int) []int {
    n := len(nums)
    prefixSum := make([]int, n+1)
    suffixSum := make([]int, n+1)

    for i := 0; i < n; i++ {
        prefixSum[i+1] = prefixSum[i] + (1 - nums[i])
    }
    for i := n - 1; i >= 0; i-- {
        suffixSum[i] = suffixSum[i+1] + nums[i]
    }

    maxScore := -1
    result := []int{}
    for i := 0; i <= n; i++ {
        score := prefixSum[i] + suffixSum[i]
        if score > maxScore {
            maxScore = score
            result = []int{i}
        } else if score == maxScore {
            result = append(result, i)
        }
    }

    return result
}