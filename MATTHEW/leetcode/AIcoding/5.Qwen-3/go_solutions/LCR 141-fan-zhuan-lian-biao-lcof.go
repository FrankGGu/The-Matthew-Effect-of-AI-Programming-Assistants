package main

func trainningPlan(fitplan []int, target int) int {
    count := 0
    sum := 0
    left := 0
    for right := 0; right < len(fitplan); right++ {
        sum += fitplan[right]
        for sum > target && left <= right {
            sum -= fitplan[left]
            left++
        }
        if sum == target {
            count++
        }
    }
    return count
}