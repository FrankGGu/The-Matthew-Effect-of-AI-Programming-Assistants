package main

func maxProfitAssignment(difficulty []int, profit []int, worker []int) int {
    n := len(difficulty)
    jobs := make([][2]int, n)
    for i := 0; i < n; i++ {
        jobs[i] = [2]int{difficulty[i], profit[i]}
    }
    sort.Slice(jobs, func(i, j int) bool {
        return jobs[i][0] < jobs[j][0]
    })
    for i := 1; i < n; i++ {
        if jobs[i][1] < jobs[i-1][1] {
            jobs[i][1] = jobs[i-1][1]
        }
    }
    for i := 0; i < n; i++ {
        difficulty[i] = jobs[i][0]
        profit[i] = jobs[i][1]
    }
    res := 0
    for _, w := range worker {
        left, right := 0, n-1
        ans := 0
        for left <= right {
            mid := left + (right-left)/2
            if difficulty[mid] <= w {
                ans = profit[mid]
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        res += ans
    }
    return res
}