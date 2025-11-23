func countNonSpecialNumbers(n int) int {
    if n < 10 {
        return n
    }

    // Calculate the number of digits in n
    digits := []int{}
    temp := n
    for temp > 0 {
        digits = append(digits, temp%10)
        temp /= 10
    }
    length := len(digits)

    // Count the non-special numbers with fewer digits than n
    count := 0
    for i := 1; i < length; i++ {
        count += 9 * pow(9, i-1)
    }

    // Count the non-special numbers with the same number of digits as n
    seen := map[int]bool{}
    for i := length - 1; i >= 0; i-- {
        currentDigit := digits[i]
        for j := 0; j < currentDigit; j++ {
            if j == 0 && i == length-1 {
                continue
            }
            if !seen[j] {
                count += pow(9, i)
            }
        }
        if seen[currentDigit] {
            break
        }
        seen[currentDigit] = true
    }

    return count
}

func pow(base, exp int) int {
    result := 1
    for exp > 0 {
        result *= base
        exp--
    }
    return result
}