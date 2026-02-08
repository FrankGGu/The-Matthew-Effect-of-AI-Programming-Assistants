package main

func minDeletions(s string, k int) int {
    freq := make([]int, 26)
    for _, c := range s {
        freq[c-'a']++
    }

    sort.Sort(sort.Reverse(sort.IntSlice(freq)))

    deletions := 0
    for i := 1; i < 26; i++ {
        if freq[i] == 0 {
            break
        }
        if freq[i] > freq[i-1]+k {
            deletions += freq[i] - (freq[i-1] + k)
        }
    }

    return deletions
}