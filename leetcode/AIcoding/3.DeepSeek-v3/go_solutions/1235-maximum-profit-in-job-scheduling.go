import (
    "sort"
)

type Job struct {
    startTime int
    endTime   int
    profit    int
}

func jobScheduling(startTime []int, endTime []int, profit []int) int {
    n := len(startTime)
    jobs := make([]Job, n)
    for i := 0; i < n; i++ {
        jobs[i] = Job{startTime[i], endTime[i], profit[i]}
    }
    sort.Slice(jobs, func(i, j int) bool {
        return jobs[i].endTime < jobs[j].endTime
    })

    dp := make([]int, n)
    dp[0] = jobs[0].profit

    for i := 1; i < n; i++ {
        profit := jobs[i].profit
        l := binarySearch(jobs, i)
        if l != -1 {
            profit += dp[l]
        }
        dp[i] = max(profit, dp[i-1])
    }
    return dp[n-1]
}

func binarySearch(jobs []Job, index int) int {
    left, right := 0, index-1
    for left <= right {
        mid := (left + right) / 2
        if jobs[mid].endTime <= jobs[index].startTime {
            if jobs[mid+1].endTime <= jobs[index].startTime {
                left = mid + 1
            } else {
                return mid
            }
        } else {
            right = mid - 1
        }
    }
    return -1
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}