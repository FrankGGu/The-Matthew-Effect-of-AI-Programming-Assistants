package main

func findColorPairs(colors []int) int {
    count := make(map[int]int)
    result := 0
    for _, color := range colors {
        if val, ok := count[color]; ok {
            result += val
        }
        count[color]++
    }
    return result
}