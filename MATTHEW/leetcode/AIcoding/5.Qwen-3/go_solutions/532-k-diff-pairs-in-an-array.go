package main

func findPairs(nums []int, k int) int {
    count := make(map[int]int)
    for _, num := range nums {
        count[num]++
    }
    result := 0
    for key := range count {
        if k == 0 {
            if count[key] >= 2 {
                result++
            }
        } else {
            if count[key+k] > 0 {
                result++
            }
        }
    }
    return result
}