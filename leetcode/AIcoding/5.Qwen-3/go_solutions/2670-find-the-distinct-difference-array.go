package main

func distinctDifferenceArray(s string) []int {
    n := len(s)
    res := make([]int, n)
    freq := make(map[rune]int)
    for _, c := range s {
        freq[c]++
    }
    leftFreq := make(map[rune]int)
    for i := 0; i < n; i++ {
        leftFreq[rune(s[i])]++
        freq[rune(s[i])]--
        leftDistinct := 0
        for _, v := range leftFreq {
            if v > 0 {
                leftDistinct++
            }
        }
        rightDistinct := 0
        for _, v := range freq {
            if v > 0 {
                rightDistinct++
            }
        }
        res[i] = leftDistinct - rightDistinct
    }
    return res
}