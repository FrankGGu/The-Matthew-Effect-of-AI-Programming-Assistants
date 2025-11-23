package main

func arrangeClothes(clothes []int) int {
    clothesMap := make(map[int]int)
    for _, cloth := range clothes {
        clothesMap[cloth]++
    }
    maxCount := 0
    for _, count := range clothesMap {
        if count > maxCount {
            maxCount = count
        }
    }
    return len(clothes) - maxCount
}