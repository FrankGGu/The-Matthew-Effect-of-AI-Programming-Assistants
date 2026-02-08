package main

func maximumSubsequenceCount(text string) int64 {
    count := make(map[rune]int)
    for _, c := range text {
        count[c]++
    }
    res := 0
    for i, c := range text {
        if c == 'a' {
            res += count['b']
        } else if c == 'b' {
            res += count['a']
        }
        count[c]--
    }
    return int64(res)
}