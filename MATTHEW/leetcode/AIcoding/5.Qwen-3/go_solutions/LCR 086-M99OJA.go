package main

func partition(s string) [][]string {
    result := [][]string{}
    path := []string{}

    var backtrack func(start int)
    backtrack = func(start int) {
        if start == len(s) {
            result = append(result, append([]string{}, path...))
            return
        }
        for i := start; i < len(s); i++ {
            if isPalindrome(s, start, i) {
                path = append(path, s[start:i+1])
                backtrack(i + 1)
                path = path[:len(path)-1]
            }
        }
    }

    backtrack(0)
    return result
}

func isPalindrome(s string, left, right int) bool {
    for left < right {
        if s[left] != s[right] {
            return false
        }
        left++
        right--
    }
    return true
}