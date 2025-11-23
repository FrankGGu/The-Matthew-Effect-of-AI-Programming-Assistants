package main

func minImpossibleOR(nums []int) int {
    set := make(map[int]bool)
    for _, num := range nums {
        set[num] = true
    }
    for i := 1; i <= 1000000; i <<= 1 {
        if !set[i] {
            return i
        }
    }
    return 1 << 20
}