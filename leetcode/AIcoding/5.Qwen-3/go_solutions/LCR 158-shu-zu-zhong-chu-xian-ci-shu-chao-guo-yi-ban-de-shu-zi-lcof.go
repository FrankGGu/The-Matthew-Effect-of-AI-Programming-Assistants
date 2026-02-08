package main

func inventoryManagement(warehouses []int, n int) int {
    if len(warehouses) == 0 {
        return 0
    }
    count := make(map[int]int)
    for _, w := range warehouses {
        count[w]++
        if count[w] == n {
            return w
        }
    }
    return -1
}