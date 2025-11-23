func maxScore(s string) int {
    max := 0
    leftZeros := 0
    rightOnes := 0

    for _, c := range s {
        if c == '1' {
            rightOnes++
        }
    }

    for i := 0; i < len(s)-1; i++ {
        if s[i] == '0' {
            leftZeros++
        } else {
            rightOnes--
        }
        current := leftZeros + rightOnes
        if current > max {
            max = current
        }
    }

    return max
}