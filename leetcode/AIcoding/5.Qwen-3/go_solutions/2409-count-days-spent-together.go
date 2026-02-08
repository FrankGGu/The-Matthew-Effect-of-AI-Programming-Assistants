package main

func countDaysTogether(arr1 []int, arr2 []int) int {
    days := make(map[int]bool)
    for _, day := range arr1 {
        days[day] = true
    }
    count := 0
    for _, day := range arr2 {
        if days[day] {
            count++
        }
    }
    return count
}