package main

func getMaximumEatenMelons(melonCounts []int, k int) int {
    n := len(melonCounts)
    for i := 0; i < k; i++ {
        maxIndex := 0
        for j := 1; j < n; j++ {
            if melonCounts[j] > melonCounts[maxIndex] {
                maxIndex = j
            }
        }
        melonCounts[maxIndex]--
    }
    sum := 0
    for _, count := range melonCounts {
        sum += count
    }
    return sum
}