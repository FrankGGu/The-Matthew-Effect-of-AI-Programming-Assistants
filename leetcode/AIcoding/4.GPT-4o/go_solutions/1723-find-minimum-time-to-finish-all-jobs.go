func minimumTimeRequired(jobs []int, k int) int {
    n := len(jobs)
    if n == 0 {
        return 0
    }

    left, right := 0, 0
    for _, job := range jobs {
        right += job
        if job > left {
            left = job
        }
    }

    for left < right {
        mid := left + (right-left)/2
        if canFinish(jobs, k, mid) {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}

func canFinish(jobs []int, k, time int) bool {
    workers := make([]int, k)
    return backtrack(jobs, workers, 0, time)
}

func backtrack(jobs []int, workers []int, index, time int) bool {
    if index == len(jobs) {
        return true
    }
    for i := 0; i < len(workers); i++ {
        if workers[i]+jobs[index] <= time {
            workers[i] += jobs[index]
            if backtrack(jobs, workers, index+1, time) {
                return true
            }
            workers[i] -= jobs[index]
        }
        if workers[i] == 0 {
            break
        }
    }
    return false
}