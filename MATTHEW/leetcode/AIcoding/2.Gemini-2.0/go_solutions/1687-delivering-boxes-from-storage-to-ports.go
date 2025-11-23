import "math"

func boxDelivering(boxes [][]int, portsCount int, maxBoxes int, maxWeight int) int {
	n := len(boxes)
	weight := make([]int, n+1)
	cost := make([]int, n+1)
	for i := 1; i <= n; i++ {
		weight[i] = weight[i-1] + boxes[i-1][1]
		if i == 1 || boxes[i-1][0] != boxes[i-2][0] {
			cost[i] = cost[i-1] + 1
		} else {
			cost[i] = cost[i-1]
		}
	}

	dp := make([]int, n+1)
	dp[0] = 0

	deque := []int{0}
	for i := 1; i <= n; i++ {
		for len(deque) > 0 && (i-deque[0] > maxBoxes || weight[i]-weight[deque[0]] > maxWeight) {
			deque = deque[1:]
		}

		dp[i] = dp[deque[0]] + cost[i] - cost[deque[0]] + 2

		for len(deque) > 0 && dp[i]-cost[i] <= dp[deque[len(deque)-1]]-cost[deque[len(deque)-1]] {
			deque = deque[:len(deque)-1]
		}
		deque = append(deque, i)
	}
	return dp[n]
}