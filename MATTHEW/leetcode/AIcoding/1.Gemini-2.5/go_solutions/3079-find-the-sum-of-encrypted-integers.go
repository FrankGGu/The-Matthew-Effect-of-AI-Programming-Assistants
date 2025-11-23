func sumOfEncryptedInt(nums []int) int {
    totalSum := 0
    for _, num := range nums {
        totalSum += encrypt(num)
    }
    return totalSum
}

func encrypt(n int) int {
    if n == 0 {
        return 0 // According to constraints, nums[i] >= 1, so 0 won't be encountered.
    }

    maxDigit := 0
    numDigits := 0
    temp := n
    for temp > 0 {
        digit := temp % 10
        if digit > maxDigit {
            maxDigit = digit
        }
        numDigits++
        temp /= 10
    }

    encryptedNum := 0
    for i := 0; i < numDigits; i++ {
        encryptedNum = encryptedNum*10 + maxDigit
    }
    return encryptedNum
}