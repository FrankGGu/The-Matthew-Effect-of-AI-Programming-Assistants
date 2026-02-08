package main

func numberOfSubstrings(s string, k int) int {
    count := make(map[byte]int)
    left := 0
    result := 0

    for right := 0; right < len(s); right++ {
        count[s[right]]++

        for count[s[right]] == k {
            result += len(s) - right
            count[s[left]]--
            left++
        }
    }

    return result
}