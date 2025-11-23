package main

func heightChecker(heights []int) int {
    expected := make([]int, len(heights))
    copy(expected, heights)
    for i := 0; i < len(expected); i++ {
        for j := 0; j < len(expected)-1; j++ {
            if expected[j] > expected[j+1] {
                expected[j], expected[j+1] = expected[j+1], expected[j]
            }
        }
    }
    count := 0
    for i := 0; i < len(heights); i++ {
        if heights[i] != expected[i] {
            count++
        }
    }
    return count
}