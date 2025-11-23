import "sort"

func minimumEffort(tasks [][]int) int {
    sort.Slice(tasks, func(i, j int) bool {
        return (tasks[i][1] - tasks[i][0]) < (tasks[j][1] - tasks[j][0])
    })
    res := 0
    for _, task := range tasks {
        if res + task[0] > task[1] {
            res += task[0]
        } else {
            res = task[1]
        }
    }
    return res
}