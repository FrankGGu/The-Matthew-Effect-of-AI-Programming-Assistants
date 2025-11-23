package main

func mostVisitedSector(sectors []int, n int) []int {
    count := make([]int, n+1)
    for i := 0; i < len(sectors); i++ {
        count[sectors[i]]++
    }
    max := 0
    result := []int{}
    for i := 1; i <= n; i++ {
        if count[i] > max {
            max = count[i]
            result = []int{i}
        } else if count[i] == max {
            result = append(result, i)
        }
    }
    return result
}