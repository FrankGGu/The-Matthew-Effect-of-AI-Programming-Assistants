func maximumSwap(num int) int {
    digits := []int{}
    for num > 0 {
        digits = append(digits, num%10)
        num /= 10
    }
    n := len(digits)
    maxIndex := make([]int, n)
    maxIndex[n-1] = n - 1
    for i := n - 2; i >= 0; i-- {
        if digits[i] > digits[maxIndex[i+1]] {
            maxIndex[i] = i
        } else {
            maxIndex[i] = maxIndex[i+1]
        }
    }
    for i := 0; i < n; i++ {
        if digits[i] < digits[maxIndex[i]] {
            digits[i], digits[maxIndex[i]] = digits[maxIndex[i]], digits[i]
            result := 0
            for j := n - 1; j >= 0; j-- {
                result = result*10 + digits[j]
            }
            return result
        }
    }
    return num
}