import "sort"

func maxProfitAssignment(difficulty []int, profit []int, worker []int) int {
    jobs := make([][]int, len(difficulty))
    for i := range difficulty {
        jobs[i] = []int{difficulty[i], profit[i]}
    }

    sort.Slice(jobs, func(i, j int) bool {
        return jobs[i][0] < jobs[j][0]
    })

    sort.Ints(worker)

    maxProfit := 0
    jobIndex := 0
    bestProfit := 0
    for _, skill := range worker {
        for jobIndex < len(jobs) && jobs[jobIndex][0] <= skill {
            bestProfit = max(bestProfit, jobs[jobIndex][1])
            jobIndex++
        }
        maxProfit += bestProfit
    }

    return maxProfit
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}