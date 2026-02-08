import "sort"

func minimumEffort(tasks [][]int) int {
    sort.Slice(tasks, func(i, j int) bool {
        return tasks[i][1]-tasks[i][0] > tasks[j][1]-tasks[j][0]
    })

    energy := 0
    for _, task := range tasks {
        if energy < task[1] {
            energy = task[1]
        }
        energy -= task[0]
    }

    energyNeeded := 0
    for _, task := range tasks {
        energyNeeded += task[0]
    }

    maxStart := 0
    currentEnergy := 0
    for _, task := range tasks {
        if currentEnergy < task[1] {
            maxStart += task[1] - currentEnergy
            currentEnergy = task[1]
        }
        currentEnergy -= task[0]
    }

    return maxStart
}