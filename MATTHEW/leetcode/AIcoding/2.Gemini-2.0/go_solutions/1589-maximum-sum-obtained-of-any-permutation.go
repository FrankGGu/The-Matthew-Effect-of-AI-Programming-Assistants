import "sort"

func maxSumRangeQuery(nums []int, requests [][]int) int {
	n := len(nums)
	diff := make([]int, n)
	for _, req := range requests {
		start, end := req[0], req[1]
		diff[start]++
		if end+1 < n {
			diff[end+1]--
		}
	}

	freq := make([]int, n)
	freq[0] = diff[0]
	for i := 1; i < n; i++ {
		freq[i] = freq[i-1] + diff[i]
	}

	sort.Ints(nums)
	sort.Ints(freq)

	ans := 0
	for i := 0; i < n; i++ {
		ans = (ans + nums[i]*freq[i]) % 1000000007
	}

	return ans
}