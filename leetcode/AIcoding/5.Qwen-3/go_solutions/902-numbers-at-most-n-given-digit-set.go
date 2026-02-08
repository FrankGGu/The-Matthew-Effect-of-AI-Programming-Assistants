package main

func atMostNGivenDigitSet(digits []byte, n int) int {
    s := strconv.Itoa(n)
    nLen := len(s)
    res := 0
    for i := 1; i < nLen; i++ {
        res += int(math.Pow(float64(len(digits)), float64(i)))
    }
    for i := 0; i < nLen; i++ {
        d := s[i]
        count := 0
        for _, digit := range digits {
            if digit < d {
                count++
            } else if digit == d {
                count++
                break
            }
        }
        res += count * int(math.Pow(float64(len(digits)), float64(nLen-i-1)))
        if count == 0 {
            return res
        }
    }
    return res
}