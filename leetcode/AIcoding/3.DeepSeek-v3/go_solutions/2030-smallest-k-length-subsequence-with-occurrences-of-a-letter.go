func smallestSubsequence(s string, k int, letter byte, repetition int) string {
    n := len(s)
    suffix := make([]int, n+1)
    for i := n - 1; i >= 0; i-- {
        suffix[i] = suffix[i+1]
        if s[i] == letter {
            suffix[i]++
        }
    }

    stack := make([]byte, 0)
    cnt := 0
    for i := 0; i < n; i++ {
        c := s[i]
        for len(stack) > 0 && stack[len(stack)-1] > c && len(stack)+n-i-1 >= k && (stack[len(stack)-1] != letter || cnt-1+suffix[i+1] >= repetition) {
            if stack[len(stack)-1] == letter {
                cnt--
            }
            stack = stack[:len(stack)-1]
        }
        if len(stack) < k {
            if c == letter {
                stack = append(stack, c)
                cnt++
            } else if k-len(stack) > repetition-cnt {
                stack = append(stack, c)
            }
        }
    }

    return string(stack)
}