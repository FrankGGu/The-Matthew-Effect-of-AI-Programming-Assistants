package main

func numberOfEmployeesWhoMetTarget(employees []int, target int) int {
    count := 0
    for _, e := range employees {
        if e >= target {
            count++
        }
    }
    return count
}