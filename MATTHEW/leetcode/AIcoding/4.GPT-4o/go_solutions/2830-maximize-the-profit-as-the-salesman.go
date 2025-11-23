func maxProfitAssignment(difficulty []int, profit []int, worker []int) int {
    n := len(difficulty)
    jobs := make([][2]int, n)
    for i := 0; i < n; i++ {
        jobs[i] = [2]int{difficulty[i], profit[i]}
    }

    sort.Slice(jobs, func(i, j int) bool {
        return jobs[i][0] < jobs[j][0]
    })

    sort.Ints(worker)

    maxProfit := 0
    currentMaxProfit := 0
    j := 0

    for _, ability := range worker {
        for j < n && jobs[j][0] <= ability {
            if jobs[j][1] > currentMaxProfit {
                currentMaxProfit = jobs[j][1]
            }
            j++
        }
        maxProfit += currentMaxProfit
    }

    return maxProfit
}