package main

func beautifulArrangement(k int) []int {
    result := make([]int, k)
    for i := 0; i < k; i++ {
        result[i] = i + 1
    }
    for i := k - 1; i > 0; i-- {
        for j := 0; j < i; j++ {
            if abs(result[j]-result[i]) == k || abs(result[j]-result[i]) == 1 {
                result[j], result[i] = result[i], result[j]
                break
            }
        }
    }
    return result
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}