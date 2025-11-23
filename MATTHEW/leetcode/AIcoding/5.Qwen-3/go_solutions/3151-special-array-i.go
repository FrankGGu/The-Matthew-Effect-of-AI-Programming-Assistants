package main

func specialArray(nums []int) int {
    for i := 0; i <= 1000; i++ {
        count := 0
        for _, num := range nums {
            if num >= i {
                count++
            }
        }
        if count == i {
            return i
        }
    }
    return -1
}