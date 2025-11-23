func maxAlternatingSum(nums []int) int64 {
    evenSum, oddSum := int64(0), int64(0)

    for _, num := range nums {
        evenSum, oddSum = max(evenSum, oddSum + int64(num)), evenSum - int64(num)
    }

    return evenSum
}

func max(a, b int64) int64 {
    if a > b {
        return a
    }
    return b
}