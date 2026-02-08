package main

func minMovesToMakePalindrome(s string) int {
    n := len(s)
    sRunes := []rune(s)
    left, right := 0, n-1
    res := 0
    for left < right {
        if sRunes[left] == sRunes[right] {
            left++
            right--
        } else {
            // Find the matching character from the right
            i := right
            for i > left && sRunes[i] != sRunes[left] {
                i--
            }
            if i == left {
                // No match found, swap with next character
                sRunes[i], sRunes[i+1] = sRunes[i+1], sRunes[i]
                res++
            } else {
                // Move the matching character to the right end
                for j := i; j < right; j++ {
                    sRunes[j], sRunes[j+1] = sRunes[j+1], sRunes[j]
                    res++
                }
                left++
                right--
            }
        }
    }
    return res
}