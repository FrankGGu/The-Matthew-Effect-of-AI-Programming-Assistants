package main

func goodDaysToRobBank(security []int, time int) []int {
    n := len(security)
    left := make([]int, n)
    right := make([]int, n)

    for i := 1; i < n; i++ {
        if security[i] <= security[i-1] {
            left[i] = left[i-1] + 1
        }
        if security[n-1-i] <= security[n-i] {
            right[n-1-i] = right[n-i] + 1
        }
    }

    result := make([]int, 0)
    for i := 0; i < n; i++ {
        if left[i] >= time && right[i] >= time {
            result = append(result, i)
        }
    }
    return result
}