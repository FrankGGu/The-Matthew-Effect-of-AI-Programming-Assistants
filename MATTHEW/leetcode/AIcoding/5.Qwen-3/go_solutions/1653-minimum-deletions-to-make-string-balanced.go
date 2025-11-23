package main

func minDeletions(s string) int {
    count := make([]int, 26)
    for _, c := range s {
        count[c-'a']++
    }

    res := 0
    for i := 24; i >= 0; i-- {
        if count[i] >= count[i+1] {
            res += count[i] - count[i+1]
            count[i] = count[i+1]
        }
    }
    return res
}