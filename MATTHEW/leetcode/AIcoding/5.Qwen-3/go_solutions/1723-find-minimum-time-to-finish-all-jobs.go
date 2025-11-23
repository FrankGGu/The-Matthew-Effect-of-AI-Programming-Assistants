package main

func minimumTimeRequired(tasks []int, workers int) int {
    sort.Ints(tasks)
    n := len(tasks)
    var res int

    var backtrack func(int, int, int, []int)
    backtrack = func(start, time, count int, assign []int) {
        if count == workers {
            res = time
            return
        }
        for i := start; i < n; i++ {
            if i > start && tasks[i] == tasks[i-1] {
                continue
            }
            if assign[i] != 0 {
                continue
            }
            assign[i] = 1
            newTime := time + tasks[i]
            if newTime >= res && res != 0 {
                assign[i] = 0
                continue
            }
            backtrack(i+1, newTime, count+1, assign)
            assign[i] = 0
        }
    }

    res = math.MaxInt64
    assign := make([]int, n)
    backtrack(0, 0, 0, assign)
    return res
}