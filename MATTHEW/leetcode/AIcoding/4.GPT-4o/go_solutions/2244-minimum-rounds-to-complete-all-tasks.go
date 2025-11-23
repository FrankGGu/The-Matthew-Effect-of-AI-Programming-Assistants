func minimumRounds(tasks []int) int {
    taskCount := make(map[int]int)
    for _, task := range tasks {
        taskCount[task]++
    }

    rounds := 0
    for _, count := range taskCount {
        if count == 1 {
            return -1
        }
        rounds += (count + 2) / 3
    }

    return rounds
}