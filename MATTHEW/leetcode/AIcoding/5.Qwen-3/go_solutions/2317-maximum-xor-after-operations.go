package main

func maximumXOR(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        maxNum |= num
    }
    return maxNum
}