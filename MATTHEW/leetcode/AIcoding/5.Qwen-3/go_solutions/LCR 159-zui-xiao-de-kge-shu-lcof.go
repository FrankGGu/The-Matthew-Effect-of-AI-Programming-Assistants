package main

func inventoryManagement(nums []int, cnt int) int {
    if len(nums) == 0 {
        return 0
    }
    m := make(map[int]int)
    for _, num := range nums {
        m[num]++
        if m[num] > len(nums)/2 {
            return num
        }
    }
    return 0
}