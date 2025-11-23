package main

func canBeEqual(nums []int, n int) bool {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    for k, v := range count {
        if v > 2 {
            return false
        }
        if v == 2 {
            if k*2 != n {
                return false
            }
        }
    }
    return true
}