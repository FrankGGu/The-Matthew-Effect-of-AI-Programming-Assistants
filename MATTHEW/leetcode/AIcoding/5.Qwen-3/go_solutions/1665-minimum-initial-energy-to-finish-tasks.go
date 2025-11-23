package main

func minInitialEnergy(tasks [][]int) int {
    sort.Slice(tasks, func(i, j int) bool {
        return tasks[i][0]+tasks[i][1] < tasks[j][0]+tasks[j][1]
    })
    energy := 0
    for _, task := range tasks {
        energy = max(energy+task[0]-task[1], 0)
    }
    return energy
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}