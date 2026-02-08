package main

func firstDayBeenInAllRooms(roomSettings []int) int {
    n := len(roomSettings)
    visited := make([]bool, n)
    current := 0
    day := 0
    for {
        if visited[current] {
            return day
        }
        visited[current] = true
        current = roomSettings[current]
        day++
    }
}