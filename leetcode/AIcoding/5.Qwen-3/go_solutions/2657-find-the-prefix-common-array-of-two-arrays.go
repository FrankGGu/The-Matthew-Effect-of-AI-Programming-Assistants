package main

func commonFinder(a []int, b []int) []int {
    n := len(a)
    res := make([]int, n)
    freq := make(map[int]int)
    count := 0
    for i := 0; i < n; i++ {
        freq[a[i]]++
        if freq[a[i]] == 1 {
            freq[b[i]]++
            if freq[b[i]] == 1 {
                count++
            }
        } else {
            freq[b[i]]++
            if freq[b[i]] == 1 {
                count++
            }
        }
        res[i] = count
    }
    return res
}