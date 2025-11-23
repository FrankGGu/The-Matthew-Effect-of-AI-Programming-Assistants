package main

func trainningPlan(plan []int) int {
    count := 0
    for _, v := range plan {
        if v%2 == 1 {
            count++
        }
    }
    return count
}