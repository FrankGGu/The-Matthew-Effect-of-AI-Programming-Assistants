package main

func minOperations(nums []int, k int) int {
    remainderCount := make(map[int]int)
    totalRemainder := 0
    for _, num := range nums {
        rem := num % k
        if rem < 0 {
            rem += k
        }
        totalRemainder += rem
        remainderCount[rem]++
    }
    totalRemainder %= k
    if totalRemainder == 0 {
        return 0
    }
    for i := 1; i < k; i++ {
        if remainderCount[i] > 0 {
            return i
        }
    }
    return k - totalRemainder
}