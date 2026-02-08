package main

func dividePlayers(n int, skill []int) int {
    sort.Ints(skill)
    total := 0
    for i := 0; i < n/2; i++ {
        total += skill[i] * skill[n-1-i]
    }
    return total
}