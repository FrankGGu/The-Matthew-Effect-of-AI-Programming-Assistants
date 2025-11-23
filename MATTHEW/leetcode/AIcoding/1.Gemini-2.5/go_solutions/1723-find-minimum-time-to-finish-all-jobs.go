package main

import (
	"sort"
)

func minimumTimeRequired(jobs []int, k int) int {
	sort.Slice(jobs, func(i, j int) bool {
		return jobs[i] > jobs[j]
	})

	left := 0
	for _, job := range jobs {
		if job > left {
			left = job
		}
	}
	right := 0
	for _, job := range jobs {
		right += job
	}

	ans := right

	for left <= right {
		mid := left + (right-left)/2
		workerLoads := make([]int, k)

		if canFinish(0, jobs, workerLoads, k, mid) {
			ans = mid
			right = mid - 1
		} else {
			left = mid + 1
		}
	}
	return ans
}

func canFinish(jobIndex int, jobs []int, workerLoads []int, k int, maxTime int) bool {
	if jobIndex == len(jobs) {
		return true
	}

	currentJob := jobs[jobIndex]

	for i := 0; i < k; i++ {
		if workerLoads[i]+currentJob <= maxTime {
			workerLoads[i] += currentJob
			if canFinish(jobIndex+1, jobs, workerLoads, k, maxTime) {
				return true
			}
			workerLoads[i] -= currentJob
		}

		if workerLoads[i] == 0 {
			break
		}
	}

	return false
}