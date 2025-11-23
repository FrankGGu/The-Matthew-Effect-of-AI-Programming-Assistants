package main

func sumZero(n int) []int {
    result := make([]int, 0, n)
    for i := 1; i < n; i++ {
        result = append(result, i)
    }
    if n%2 == 1 {
        result = append(result, 0)
    } else {
        result = append(result, -n/2)
    }
    return result
}