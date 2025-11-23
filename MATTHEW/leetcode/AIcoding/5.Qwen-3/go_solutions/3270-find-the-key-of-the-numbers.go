package main

func findKey(nums []int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    for key, val := range count {
        if val == 1 {
            return key
        }
    }
    return -1
}