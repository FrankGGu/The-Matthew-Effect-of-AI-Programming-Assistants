func maxFactorScore(nums []int) int64 {
    maxScore := int64(0)
    for _, num := range nums {
        for i := 1; i*i <= num; i++ {
            if num%i == 0 {
                maxScore = max(maxScore, int64(i))
                maxScore = max(maxScore, int64(num/i))
            }
        }
    }
    return maxScore
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}