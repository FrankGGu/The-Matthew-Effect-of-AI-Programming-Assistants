package main

func divisibilityArray(word string) []int {
    n := len(word)
    result := make([]int, n)
    mod := int64(0)
    for i := 0; i < n; i++ {
        mod = (mod*10 + int64(word[i]-'0')) % int64(i+1)
        if mod == 0 {
            result[i] = 1
        } else {
            result[i] = 0
        }
    }
    return result
}