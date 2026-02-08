package main

func minSessions(tasks []int, sessionTime int) int {
    n := len(tasks)
    var res int
    sort.Ints(tasks)
    for i := 0; i < n; i++ {
        if tasks[i] > sessionTime {
            return -1
        }
    }
    var backtrack func(int, []int)
    backtrack = func(start int, sessions []int) {
        if start == n {
            res = min(res, len(sessions))
            return
        }
        for i := 0; i < len(sessions); i++ {
            if sessions[i]+tasks[start] <= sessionTime {
                sessions[i] += tasks[start]
                backtrack(start+1, sessions)
                sessions[i] -= tasks[start]
                if sessions[i] == 0 {
                    break
                }
            }
        }
        sessions = append(sessions, tasks[start])
        backtrack(start+1, sessions)
        sessions = sessions[:len(sessions)-1]
    }
    res = n
    backtrack(0, []int{})
    return res
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}