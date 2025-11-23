package main

func findMatrix(nums []int) [][]int {
    count := make(map[int]int)
    maxFreq := 0
    for _, num := range nums {
        count[num]++
        if count[num] > maxFreq {
            maxFreq = count[num]
        }
    }

    result := make([][]int, maxFreq)
    for i := range result {
        result[i] = make([]int, 0)
    }

    for num, freq := range count {
        for i := 0; i < freq; i++ {
            result[i] = append(result[i], num)
        }
    }

    return result
}