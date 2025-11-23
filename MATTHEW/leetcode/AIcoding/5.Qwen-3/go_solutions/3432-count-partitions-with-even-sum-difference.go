package main

func numPairsDivisibleBy60(nums []int) int {
    count := make([]int, 60)
    for _, num := range nums {
        mod := num % 60
        count[mod]++
    }
    res := 0
    for i := 1; i < 30; i++ {
        res += count[i] * count[60-i]
    }
    res += count[0] * (count[0] - 1) / 2
    return res
}