func maximumSum(nums []int) int {
    sumMap := make(map[int]int)
    maxSum := -1

    for _, num := range nums {
        digitSum := 0
        n := num
        for n > 0 {
            digitSum += n % 10
            n /= 10
        }
        if prev, exists := sumMap[digitSum]; exists {
            maxSum = max(maxSum, prev + num)
        }
        sumMap[digitSum] = max(sumMap[digitSum], num)
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}