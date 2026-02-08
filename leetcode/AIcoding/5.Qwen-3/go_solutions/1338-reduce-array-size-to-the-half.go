package main

func minSetSize(arr []int) int {
    count := make(map[int]int)
    for _, num := range arr {
        count[num]++
    }

    var freq []int
    for _, v := range count {
        freq = append(freq, v)
    }

    sort.Ints(freq)

    res, total := 0, 0
    for i := len(freq) - 1; i >= 0; i-- {
        total += freq[i]
        res++
        if total >= len(arr)/2 {
            return res
        }
    }

    return res
}