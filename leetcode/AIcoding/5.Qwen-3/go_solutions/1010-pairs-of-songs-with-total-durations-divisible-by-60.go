package main

func numPairsDivisibleBy60(nums []int) int {
    count := make([]int, 60)
    result := 0
    for _, num := range nums {
        remainder := num % 60
        if remainder == 0 {
            result += count[0]
        } else {
            result += count[60-remainder]
        }
        count[remainder]++
    }
    return result
}