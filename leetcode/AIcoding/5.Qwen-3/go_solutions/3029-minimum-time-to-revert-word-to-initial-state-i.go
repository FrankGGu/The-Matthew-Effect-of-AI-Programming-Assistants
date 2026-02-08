package main

func minimumTimeToRevert(word string, k int) int {
    n := len(word)
    for i := 1; i <= n; i++ {
        if i*k >= n {
            return i
        }
        if word[:n-i*k] == word[i*k:] {
            return i
        }
    }
    return n
}