import (
	"sort"
)

func maxFrequencyScore(nums []int, k int) int {
	sort.Ints(nums)
	n := len(nums)
	prefixSum := make([]int, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	ans := 0
	for i := 0; i < n; i++ {
		l, r := 0, i
		left := -1
		for l <= r {
			mid := l + (r-l)/2
			cost := (i-mid+1)*nums[i] - (prefixSum[i+1] - prefixSum[mid])
			if cost <= k {
				left = mid
				r = mid - 1
			} else {
				l = mid + 1
			}
		}

		l, r = i, n-1
		right := -1
		for l <= r {
			mid := l + (r-l)/2
			cost := (prefixSum[mid+1] - prefixSum[i]) - (mid-i+1)*nums[i]
			if cost <= k {
				right = mid
				l = mid + 1
			} else {
				r = mid - 1
			}
		}

		count := 0
		if left != -1 && right != -1 {
			if right >= left {
				count = right - left + 1
			}
		} else if left != -1 {
			count = i - left + 1
		} else if right != -1 {
			count = right - i + 1
		}

		ans = max(ans, count)
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func main() {}