package main

func minimumValue(s string) int {
    left := 0
    right := len(s) - 1

    for left < right && s[left] == s[right] {
        if s[left] == s[left+1] {
            left++
        } else {
            left++
        }

        if s[right] == s[right-1] {
            right--
        } else {
            right--
        }
    }

    return right - left + 1
}