func countSpecialNumbers(n int) int {
    digits := make([]int, 0)
    for n > 0 {
        digits = append(digits, n%10)
        n /= 10
    }
    length := len(digits)
    count := 0

    for i := 1; i < length; i++ {
        count += 9 * pow(9, i-1)
    }

    used := make([]bool, 10)
    for i := length - 1; i >= 0; i-- {
        for j := 0; j < digits[i]; j++ {
            if i == length-1 && j == 0 {
                continue
            }
            if !used[j] {
                count += pow(9, i)
            }
        }
        if used[digits[i]] {
            break
        }
        used[digits[i]] = true
    }

    return count + 1
}

func pow(x, y int) int {
    result := 1
    for y > 0 {
        result *= x
        y--
    }
    return result
}