package main

func smallestSubsequence(s string, k int, letter byte, minOccurrences int) string {
    n := len(s)
    count := 0
    for i := 0; i < n; i++ {
        if s[i] == letter {
            count++
        }
    }

    stack := []byte{}
    remaining := n
    for i := 0; i < n; i++ {
        remaining--
        if s[i] == letter {
            count--
        }

        for len(stack) > 0 && stack[len(stack)-1] > s[i] && (len(stack)-1 + remaining >= k) && (len(stack)-1 + remaining - (count > 0 ? 0 : 1) >= k) {
            if stack[len(stack)-1] == letter && (len(stack)-1 + remaining - (count > 0 ? 0 : 1) >= k) {
                stack = stack[:len(stack)-1]
            } else {
                break
            }
        }

        if len(stack) < k {
            stack = append(stack, s[i])
        }
    }

    return string(stack)
}