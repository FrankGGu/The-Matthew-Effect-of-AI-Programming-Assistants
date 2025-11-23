package main

func sequentialDigits(n int) []int {
    result := []int{}
    for i := 1; i <= 9; i++ {
        current := i
        for j := i + 1; j <= 9; j++ {
            current = current*10 + j
            if current >= n {
                result = append(result, current)
            }
        }
    }
    sort.Ints(result)
    return result
}