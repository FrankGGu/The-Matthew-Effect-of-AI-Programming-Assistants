package main

func minOperations(s string) int {
    freq := make([]int, 26)
    for _, c := range s {
        freq[c-'a']++
    }

    maxFreq := 0
    for _, f := range freq {
        if f > maxFreq {
            maxFreq = f
        }
    }

    ops := 0
    for _, f := range freq {
        if f != 0 && f != maxFreq {
            ops += f
        }
    }

    return ops
}