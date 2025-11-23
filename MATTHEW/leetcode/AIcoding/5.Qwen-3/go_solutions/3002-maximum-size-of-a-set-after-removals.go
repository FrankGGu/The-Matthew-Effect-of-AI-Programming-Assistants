package main

func maximumSizeSet(nums []int, m int) int {
    freq := make(map[int]int)
    for _, num := range nums {
        freq[num]++
    }

    count := make([]int, 0)
    for _, v := range freq {
        count = append(count, v)
    }

    sort.Ints(count)

    res := 0
    for i := len(count) - 1; i >= 0 && m > 0; i-- {
        if m >= count[i] {
            res += count[i]
            m -= count[i]
        } else {
            res += m
            m = 0
        }
    }

    return res
}