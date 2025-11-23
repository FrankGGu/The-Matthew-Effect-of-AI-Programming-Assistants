func smallestK(s string, k int, letter byte, repetition int) string {
    n := len(s)
    stack := []byte{}
    countLetter := 0
    totalLetter := 0

    for i := 0; i < n; i++ {
        if s[i] == letter {
            totalLetter++
        }
    }

    for i := 0; i < n; i++ {
        for len(stack) > 0 && stack[len(stack)-1] > s[i] && (n-i-1+len(stack) > k) && (stack[len(stack)-1] != letter || countLetter > repetition) {
            stack = stack[:len(stack)-1]
            if stack[len(stack)-1] == letter {
                countLetter--
            }
        }
        if len(stack) < k {
            if s[i] == letter {
                stack = append(stack, s[i])
                countLetter++
            } else if k-len(stack) > repetition-countLetter {
                stack = append(stack, s[i])
            }
        }
    }

    return string(stack[:k])
}