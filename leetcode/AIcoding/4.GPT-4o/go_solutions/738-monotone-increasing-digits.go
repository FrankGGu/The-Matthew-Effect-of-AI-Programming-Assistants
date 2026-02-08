func monotoneIncreasingDigits(N int) int {
    digits := []int{}
    for N > 0 {
        digits = append([]int{N % 10}, digits...)
        N /= 10
    }

    n := len(digits)
    mark := n

    for i := n - 1; i > 0; i-- {
        if digits[i] < digits[i-1] {
            mark = i
            digits[i-1]--
        }
    }

    for i := mark; i < n; i++ {
        digits[i] = 9
    }

    result := 0
    for _, d := range digits {
        result = result*10 + d
    }

    return result
}