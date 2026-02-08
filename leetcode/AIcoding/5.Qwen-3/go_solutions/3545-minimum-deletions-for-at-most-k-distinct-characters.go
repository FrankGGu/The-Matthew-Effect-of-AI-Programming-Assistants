package main

func minDeletions(s string, k int) int {
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }

    freq := make([]int, 26)
    for c, cnt := range count {
        freq[c-'a'] = cnt
    }

    sort.Sort(sort.Reverse(sort.IntSlice(freq)))

    res := 0
    for i := 0; i < 26 && freq[i] > 0; i++ {
        if i < k {
            continue
        }
        if freq[i] == 0 {
            break
        }
        if freq[i] <= freq[k-1] {
            continue
        }
        res += freq[i] - freq[k-1]
        freq[i] = freq[k-1]
    }

    return res
}