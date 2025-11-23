package main

func sumIndicesWithKSetBits(nums []int, k int) int {
    sum := 0
    for i := 0; i < len(nums); i++ {
        count := 0
        num := i
        for num > 0 {
            count += num & 1
            num >>= 1
        }
        if count == k {
            sum += nums[i]
        }
    }
    return sum
}