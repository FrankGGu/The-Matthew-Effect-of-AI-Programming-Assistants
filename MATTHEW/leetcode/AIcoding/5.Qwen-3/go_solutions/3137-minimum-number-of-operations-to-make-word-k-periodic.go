package main

func minOperationsToMakeKPeriodic(word string, k int) int64 {
    count := make(map[string]int)
    n := len(word)
    for i := 0; i < n; i += k {
        if i+k <= n {
            substr := word[i : i+k]
            count[substr]++
        }
    }
    maxFreq := 0
    for _, v := range count {
        if v > maxFreq {
            maxFreq = v
        }
    }
    return int64(n/k - maxFreq)
}