package main

func maxDistinctElements(nums []int, k int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }

    distinct := 0
    for num, freq := range count {
        if freq == 1 {
            distinct++
        } else {
            if freq > 1 {
                distinct++
                if freq > 2 {
                    distinct += freq - 2
                }
            }
        }
    }

    return distinct
}