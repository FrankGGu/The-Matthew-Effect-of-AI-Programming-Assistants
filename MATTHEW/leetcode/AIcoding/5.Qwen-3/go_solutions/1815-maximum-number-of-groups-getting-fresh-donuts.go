package main

func maxGroups(candies []int) int {
    count := make(map[int]int)
    for _, c := range candies {
        count[c]++
    }

    var freq []int
    for _, v := range count {
        freq = append(freq, v)
    }

    sort.Ints(freq)

    res := 0
    for i := len(freq) - 1; i >= 0; i-- {
        if freq[i] > 0 {
            res++
            for j := i; j >= 0; j-- {
                freq[j]--
            }
        }
    }

    return res
}