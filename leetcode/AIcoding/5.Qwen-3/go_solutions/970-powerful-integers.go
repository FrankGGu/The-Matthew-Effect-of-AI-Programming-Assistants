package main

func powerfulIntegers(x int, y int, maxSum int) []int {
    result := make(map[int]bool)
    for i := 0; x^i <= maxSum; i++ {
        for j := 0; y^j <= maxSum; j++ {
            sum := x^i + y^j
            if sum <= maxSum {
                result[sum] = true
            }
        }
    }
    var output []int
    for key := range result {
        output = append(output, key)
    }
    return output
}