package main

func findKOr(nums []int, k int) int {
    result := 0
    for i := 0; i < 32; i++ {
        count := 0
        for _, num := range nums {
            if (num >> i) & 1 == 1 {
                count++
            }
        }
        if count >= k {
            result |= (1 << i)
        }
    }
    return result
}