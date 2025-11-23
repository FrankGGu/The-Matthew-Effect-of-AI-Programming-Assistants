package main

func countKSubseqes(s string, k int) int {
    mod := int64(1000000007)
    freq := make([]int, 26)
    for _, c := range s {
        freq[int(c-'a')]++
    }
    var total int
    for i := 0; i < 26; i++ {
        if freq[i] > 0 {
            total++
        }
    }
    if total < k {
        return 0
    }
    sort.Ints(freq)
    var res int64 = 1
    for i := 25; i >= 0 && k > 0; i-- {
        if freq[i] == 0 {
            continue
        }
        if k == 1 {
            res = (res * int64(freq[i])) % mod
            break
        }
        if freq[i] > 0 {
            res = (res * int64(freq[i])) % mod
            k--
        }
    }
    return int(res)
}