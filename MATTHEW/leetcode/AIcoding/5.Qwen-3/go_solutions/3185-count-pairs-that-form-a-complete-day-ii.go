package main

func countCompleteDayPairs(arr []int, k int) int {
    count := 0
    remainderCount := make(map[int]int)
    for _, num := range arr {
        rem := num % k
        complement := (k - rem) % k
        count += remainderCount[complement]
        remainderCount[rem]++
    }
    return count
}