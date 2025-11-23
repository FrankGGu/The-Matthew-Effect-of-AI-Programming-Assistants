package main

func maxPalindromes(s string) int {
    freq := make([]int, 26)
    for _, c := range s {
        freq[c-'a']++
    }

    oddCount := 0
    for _, v := range freq {
        if v%2 == 1 {
            oddCount++
        }
    }

    if oddCount <= 1 {
        return len(s)
    }

    return len(s) - (oddCount - 1)
}