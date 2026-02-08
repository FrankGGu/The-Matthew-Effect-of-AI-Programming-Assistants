func sumOfEncryptedInt(nums []int) int {
    sum := 0
    for _, num := range nums {
        maxDigit := 0
        count := 0
        n := num
        for n > 0 {
            digit := n % 10
            if digit > maxDigit {
                maxDigit = digit
            }
            n /= 10
            count++
        }
        encrypted := 0
        for i := 0; i < count; i++ {
            encrypted = encrypted*10 + maxDigit
        }
        sum += encrypted
    }
    return sum
}