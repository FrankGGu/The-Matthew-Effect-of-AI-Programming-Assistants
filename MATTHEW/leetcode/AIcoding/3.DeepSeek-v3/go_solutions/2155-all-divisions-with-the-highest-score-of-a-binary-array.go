func maxScoreIndices(nums []int) []int {
    n := len(nums)
    leftZeros := make([]int, n+1)
    rightOnes := make([]int, n+1)

    for i := 0; i < n; i++ {
        leftZeros[i+1] = leftZeros[i]
        if nums[i] == 0 {
            leftZeros[i+1]++
        }
    }

    for i := n - 1; i >= 0; i-- {
        rightOnes[i] = rightOnes[i+1]
        if nums[i] == 1 {
            rightOnes[i]++
        }
    }

    maxScore := 0
    scores := make([]int, n+1)
    for i := 0; i <= n; i++ {
        scores[i] = leftZeros[i] + rightOnes[i]
        if scores[i] > maxScore {
            maxScore = scores[i]
        }
    }

    result := []int{}
    for i := 0; i <= n; i++ {
        if scores[i] == maxScore {
            result = append(result, i)
        }
    }

    return result
}