package main

func smallestSubsequence(s string, k int, letter byte, threshold int) string {
    stack := []byte{}
    count := make([]int, 26)
    for i := range s {
        count[s[i]-'a']++
    }
    used := make([]bool, 26)
    for i := range s {
        c := s[i]
        count[c-'a']--
        if used[c-'a'] {
            continue
        }
        for len(stack) > 0 && stack[len(stack)-1] < c && count[stack[len(stack)-1]-'a'] > 0 {
            used[stack[len(stack)-1]-'a'] = false
            stack = stack[:len(stack)-1]
        }
        stack = append(stack, c)
        used[c-'a'] = true
    }
    result := make([]byte, k)
    for i := 0; i < k; i++ {
        result[i] = stack[i]
    }
    return string(result)
}