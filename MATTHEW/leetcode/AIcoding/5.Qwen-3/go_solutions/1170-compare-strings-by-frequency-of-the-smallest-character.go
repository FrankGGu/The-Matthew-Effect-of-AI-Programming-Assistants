package main

func numSmallerThanCurrent(nums []int) int {
    count := make([]int, 101)
    for _, num := range nums {
        count[num]++
    }
    for i := 1; i < 101; i++ {
        count[i] += count[i-1]
    }
    result := make([]int, len(nums))
    for i, num := range nums {
        result[i] = count[num-1]
    }
    return result[0]
}