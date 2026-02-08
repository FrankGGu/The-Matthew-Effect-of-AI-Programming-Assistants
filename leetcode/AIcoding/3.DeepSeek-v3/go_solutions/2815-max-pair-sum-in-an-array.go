func maxSum(nums []int) int {
    maxDigit := func(num int) int {
        max := 0
        for num > 0 {
            digit := num % 10
            if digit > max {
                max = digit
            }
            num /= 10
        }
        return max
    }

    maxSum := -1
    digitMap := make(map[int]int)

    for _, num := range nums {
        digit := maxDigit(num)
        if val, exists := digitMap[digit]; exists {
            currentSum := val + num
            if currentSum > maxSum {
                maxSum = currentSum
            }
            if num > val {
                digitMap[digit] = num
            }
        } else {
            digitMap[digit] = num
        }
    }

    return maxSum
}