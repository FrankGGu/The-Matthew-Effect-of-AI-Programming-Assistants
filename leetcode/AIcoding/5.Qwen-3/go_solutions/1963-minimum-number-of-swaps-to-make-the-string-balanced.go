package main

func minSwaps(s string) int {
    left := 0
    right := len(s) - 1
    swaps := 0
    for left < right {
        if s[left] == '[' {
            left++
        } else if s[right] == ']' {
            right--
        } else {
            swaps++
            left++
            right--
        }
    }
    return swaps / 2
}