package main

func maxProduct(s string) int {
    var palindromes []string
    n := len(s)
    for mask := 1; mask < (1 << n); mask++ {
        var sub string
        for i := 0; i < n; i++ {
            if mask & (1 << i) != 0 {
                sub += string(s[i])
            }
        }
        if isPalindrome(sub) {
            palindromes = append(palindromes, sub)
        }
    }
    maxProd := 0
    m := len(palindromes)
    for i := 0; i < m; i++ {
        for j := i + 1; j < m; j++ {
            if !overlapping(palindromes[i], palindromes[j]) {
                maxProd = max(maxProd, len(palindromes[i])*len(palindromes[j]))
            }
        }
    }
    return maxProd
}

func isPalindrome(s string) bool {
    for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
        if s[i] != s[j] {
            return false
        }
    }
    return true
}

func overlapping(a, b string) bool {
    set := make(map[rune]bool)
    for _, c := range a {
        set[c] = true
    }
    for _, c := range b {
        if set[c] {
            return true
        }
    }
    return false
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}