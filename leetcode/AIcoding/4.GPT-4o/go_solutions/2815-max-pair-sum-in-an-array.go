func maxSum(nums []int) int {
    maxSum := 0
    numMap := make(map[int]int)

    for _, num := range nums {
        digitSum := 0
        temp := num
        for temp > 0 {
            digitSum += temp % 10
            temp /= 10
        }
        if _, exists := numMap[digitSum]; exists {
            maxSum = max(maxSum, num + numMap[digitSum])
        }
        numMap[digitSum] = max(num, numMap[digitSum])
    }

    return maxSum
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}