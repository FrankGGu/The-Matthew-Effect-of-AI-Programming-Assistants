package main

func canConstructPalindrome(s string, k int) bool {
    if len(s) < k {
        return false
    }
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }
    oddCount := 0
    for _, v := range count {
        if v%2 != 0 {
            oddCount++
        }
    }
    return oddCount <= k
}