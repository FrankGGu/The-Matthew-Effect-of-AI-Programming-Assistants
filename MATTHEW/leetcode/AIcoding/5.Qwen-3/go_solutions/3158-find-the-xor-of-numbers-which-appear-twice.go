package main

func duplicateNumbersXOR(nums []int) int {
    count := make(map[int]int)
    result := 0
    for _, num := range nums {
        count[num]++
        if count[num] == 2 {
            result ^= num
        }
    }
    return result
}