package main

func countCompleteDayPairs(hours []int, k int) int {
    count := 0
    remainderCount := make(map[int]int)
    for _, hour := range hours {
        remainder := hour % k
        complement := (k - remainder) % k
        count += remainderCount[complement]
        remainderCount[remainder]++
    }
    return count
}