package main

func minOperations(nums []int, k int) int {
    xor := 0
    for _, num := range nums {
        xor ^= num
    }
    operations := 0
    for xor != k {
        for i := 0; i < 32; i++ {
            if (xor >> i) & 1 != (k >> i) & 1 {
                xor ^= (1 << i)
                operations++
                break
            }
        }
    }
    return operations
}