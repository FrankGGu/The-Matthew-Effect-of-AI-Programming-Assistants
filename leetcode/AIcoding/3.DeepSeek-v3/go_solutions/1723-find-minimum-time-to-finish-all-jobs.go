func minimumTimeRequired(jobs []int, k int) int {
    n := len(jobs)
    sort.Sort(sort.Reverse(sort.IntSlice(jobs)))
    left, right := jobs[0], 0
    for _, job := range jobs {
        right += job
    }

    for left < right {
        mid := (left + right) / 2
        workers := make([]int, k)
        if backtrack(jobs, workers, 0, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func backtrack(jobs []int, workers []int, idx int, limit int) bool {
    if idx == len(jobs) {
        return true
    }
    job := jobs[idx]
    for i := 0; i < len(workers); i++ {
        if workers[i]+job <= limit {
            workers[i] += job
            if backtrack(jobs, workers, idx+1, limit) {
                return true
            }
            workers[i] -= job
        }
        if workers[i] == 0 || workers[i]+job == limit {
            break
        }
    }
    return false
}