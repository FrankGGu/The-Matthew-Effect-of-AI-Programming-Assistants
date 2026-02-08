package main

func numberOfSubstrings(s string, k int) int {
    count := make([]int, 3)
    left := 0
    result := 0
    for right := 0; right < len(s); right++ {
        count[s[right]-'a']++
        for count[0] > 0 && count[1] > 0 && count[2] > 0 {
            count[s[left]-'a']--
            left++
        }
        result += left
    }
    return result
}