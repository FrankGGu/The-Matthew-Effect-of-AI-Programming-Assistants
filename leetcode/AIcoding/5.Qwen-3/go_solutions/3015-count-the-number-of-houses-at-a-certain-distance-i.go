package main

func numberOfHouses(streets []int) int {
    count := make(map[int]int)
    for _, s := range streets {
        count[s]++
    }
    return count[1]
}