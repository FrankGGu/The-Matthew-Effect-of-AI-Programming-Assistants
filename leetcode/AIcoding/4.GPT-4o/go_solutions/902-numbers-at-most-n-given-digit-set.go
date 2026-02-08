func atMostNGivenDigitSet(digits []string, n int) int {
    s := strconv.Itoa(n)
    lenN := len(s)
    lenD := len(digits)
    count := 0

    for i := 1; i < lenN; i++ {
        count += int(math.Pow(float64(lenD), float64(i)))
    }

    for i := 0; i < lenN; i++ {
        hasSmaller := false
        for _, digit := range digits {
            if digit[0] < s[i] {
                hasSmaller = true
                count += int(math.Pow(float64(lenD), float64(lenN-i-1)))
            } else if digit[0] == s[i] {
                break
            }
        }
        if !hasSmaller {
            return count
        }
    }

    return count + 1
}