package main

func busyStudent(startTime []int, endTime []int) int {
    count := 0
    for i := 0; i < len(startTime); i++ {
        if startTime[i] <= endTime[i] {
            count++
        }
    }
    return count
}