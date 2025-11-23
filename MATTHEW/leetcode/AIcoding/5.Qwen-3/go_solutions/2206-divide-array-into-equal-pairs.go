package main

func divideArray(nums []int) bool {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    for _, v := range count {
        if v%2 != 0 {
            return false
        }
    }
    return true
}