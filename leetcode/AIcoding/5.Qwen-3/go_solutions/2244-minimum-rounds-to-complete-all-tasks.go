package main

func minimumRounds(tasks []int) int {
    count := make(map[int]int)
    for _, t := range tasks {
        count[t]++
    }

    rounds := 0
    for _, c := range count {
        if c == 1 {
            return -1
        }
        rounds += c / 3
        if c % 3 != 0 {
            rounds++
        }
    }
    return rounds
}