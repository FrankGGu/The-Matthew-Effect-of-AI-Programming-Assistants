package main

func totalHammingDistance(nums []int) int {
    var total int
    for i := 0; i < 32; i++ {
        count := 0
        for _, num := range nums {
            if (num >> i) & 1 == 1 {
                count++
            }
        }
        total += count * (len(nums) - count)
    }
    return total
}