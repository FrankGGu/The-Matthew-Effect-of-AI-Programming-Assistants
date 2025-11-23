package main

func inventoryManagement(management []int, cnt int) int {
    m := make(map[int]int)
    for _, num := range management {
        m[num]++
        if m[num] > cnt {
            return num
        }
    }
    return -1
}