package main

func countPairs(nums []int, queries map[int][]int) []int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    freq := make([]int, maxNum+1)
    for _, num := range nums {
        freq[num]++
    }

    for i := 1; i <= maxNum; i++ {
        for j := i * 2; j <= maxNum; j += i {
            freq[j] += freq[i]
        }
    }

    result := make([]int, len(queries))
    for idx, query := range queries {
        a, b := query[0], query[1]
        count := 0
        for i := a; i <= b; i++ {
            count += freq[i]
        }
        result[idx] = count
    }

    return result
}