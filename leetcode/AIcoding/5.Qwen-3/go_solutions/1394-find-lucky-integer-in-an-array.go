package main

func findLucky(arr []int) int {
    count := make(map[int]int)
    for _, num := range arr {
        count[num]++
    }
    var lucky int = -1
    for key, value := range count {
        if key == value {
            if key > lucky {
                lucky = key
            }
        }
    }
    return lucky
}