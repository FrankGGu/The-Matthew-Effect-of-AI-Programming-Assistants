package main

func canConstruct(ransomNote string, magazine string) bool {
    if len(ransomNote) > len(magazine) {
        return false
    }
    count := make([]int, 26)
    for _, c := range ransomNote {
        count[c-'a']++
    }
    for _, c := range magazine {
        if count[c-'a'] > 0 {
            count[c-'a']--
        }
    }
    for _, v := range count {
        if v > 0 {
            return false
        }
    }
    return true
}