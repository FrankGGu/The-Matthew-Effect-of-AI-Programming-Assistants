package main

func powerfulIntegers(x int, y int, bound int) []int {
    result := make([]int, 0)
    seen := make(map[int]bool)
    for i := 0; i <= 100; i++ {
        for j := 0; j <= 100; j++ {
            val := x^i + y^j
            if val <= bound && !seen[val] {
                seen[val] = true
                result = append(result, val)
            }
        }
    }
    return result
}