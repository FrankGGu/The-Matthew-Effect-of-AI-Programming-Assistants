package main

func shortestSubarray(nums []int, k int) int {
	n := len(nums)
	preSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		preSum[i+1] = preSum[i] + nums[i]
	}

	minLen := n + 1
	queue := []int{}
	for i := 0; i < n+1; i++ {
		for len(queue) > 0 {
			j := queue[0]
			if preSum[i]-preSum[j] >= k {
				minLen = min(minLen, i-j)
				queue = queue[1:]
			} else {
				break
			}
		}
		for len(queue) > 0 && preSum[i] <= preSum[queue[len(queue)-1]] {
			queue = queue[:len(queue)-1]
		}
		queue = append(queue, i)
	}
	if minLen == n+1 {
		return -1
	}
	return minLen
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}