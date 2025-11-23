import "sort"

func minimumTime(nums1 []int, nums2 []int, x int) int {
	n := len(nums1)
	items := make([][]int, n)
	sum1 := 0
	for i := 0; i < n; i++ {
		items[i] = []int{nums1[i], nums2[i]}
		sum1 += nums1[i]
	}

	sort.Slice(items, func(i, j int) bool {
		return items[i][1] > items[j][1]
	})

	dp := make([]int, n+1)
	for i := 0; i < n; i++ {
		for j := n - 1; j >= 0; j-- {
			dp[j+1] = max(dp[j+1], dp[j]+items[i][0]+items[i][1]*(j+1))
		}
	}

	ans := -1
	for t := 0; t <= n; t++ {
		if sum1+t*sum(nums2) - dp[t] <= x {
			ans = t
			break
		}
	}

	return ans
}

func sum(nums []int) int {
	sum := 0
	for _, num := range nums {
		sum += num
	}
	return sum
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}