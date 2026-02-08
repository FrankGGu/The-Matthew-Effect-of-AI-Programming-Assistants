package main

func countSubseqWithUniqueMiddle(nums []int) int {
    mod := 1000000007
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }
    res := 0
    for k := range freq {
        cnt := freq[k]
        res = (res + cnt*(cnt-1)/2) % mod
    }
    return res
}