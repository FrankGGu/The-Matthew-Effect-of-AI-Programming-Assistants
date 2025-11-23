package main

func earliestSecond(word string) int {
    n := len(word)
    count := make([]int, 26)
    for i := 0; i < n; i++ {
        count[word[i]-'a']++
    }
    res := 0
    for i := 0; i < n; i++ {
        if count[word[i]-'a'] > 1 {
            res++
        }
        count[word[i]-'a']--
    }
    return res
}