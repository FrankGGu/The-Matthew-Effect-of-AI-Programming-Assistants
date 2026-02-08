package main

func minBouquets(arr []int, m int) int {
    n := len(arr)
    if n == 0 {
        return 0
    }
    count := make(map[int]int)
    for _, num := range arr {
        count[num]++
    }
    maxFreq := 0
    for _, v := range count {
        if v > maxFreq {
            maxFreq = v
        }
    }
    if maxFreq > m {
        return -1
    }
    res := 0
    for i := 0; i < n; i++ {
        if count[arr[i]] > 0 {
            res++
            count[arr[i]]--
        }
    }
    return res
}