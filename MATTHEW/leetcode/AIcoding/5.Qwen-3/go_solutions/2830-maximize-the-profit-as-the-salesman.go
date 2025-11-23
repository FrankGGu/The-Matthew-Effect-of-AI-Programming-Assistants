package main

func maxProfitAssignment(difficulty []int, profit []int, worker []int) int {
    jobs := make([][2]int, len(difficulty))
    for i := range difficulty {
        jobs[i] = [2]int{difficulty[i], profit[i]}
    }
    sort.Slice(jobs, func(i, j int) bool {
        return jobs[i][0] < jobs[j][0]
    })
    for i := 1; i < len(jobs); i++ {
        if jobs[i][1] < jobs[i-1][1] {
            jobs[i][1] = jobs[i-1][1]
        }
    }
    for i := range worker {
        low, high := 0, len(jobs)-1
        best := 0
        for low <= high {
            mid := (low + high) / 2
            if jobs[mid][0] <= worker[i] {
                best = jobs[mid][1]
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        worker[i] = best
    }
    res := 0
    for _, p := range worker {
        res += p
    }
    return res
}