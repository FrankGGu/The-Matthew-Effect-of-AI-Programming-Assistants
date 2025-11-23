package main

func minDeletions(s string) int {
    freq := make([]int, 26)
    for _, c := range s {
        freq[c-'a']++
    }

    used := make(map[int]bool)
    deletions := 0

    for i := 0; i < 26; i++ {
        for freq[i] > 0 && used[freq[i]] {
            freq[i]--
            deletions++
        }
        if freq[i] > 0 {
            used[freq[i]] = true
        }
    }

    return deletions
}