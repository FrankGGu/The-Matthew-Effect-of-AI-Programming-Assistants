import "container/list"

func maxResult(nums []int, k int) int {
	n := len(nums)
	dp := make([]int, n)

	dp[0] = nums[0]

	deque := list.New()
	deque.PushBack(0)

	for i := 1; i < n; i++ {
		for deque.Len() > 0 && deque.Front().Value.(int) < i-k {
			deque.Remove(deque.Front())
		}

		dp[i] = nums[i] + dp[deque.Front().Value.(int)]

		for deque.Len() > 0 && dp[deque.Back().Value.(int)] <= dp[i] {
			deque.Remove(deque.Back())
		}

		deque.PushBack(i)
	}

	return dp[n-1]
}