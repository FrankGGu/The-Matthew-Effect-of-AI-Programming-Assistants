import (
	"math"
	"sort"
)

func minimumDifference(nums []int) int {
	n := len(nums) / 2
	sum := 0
	for _, num := range nums {
		sum += num
	}

	left := nums[:n]
	right := nums[n:]

	leftSums := make([][]int, n+1)
	rightSums := make([][]int, n+1)

	for i := 0; i <= n; i++ {
		leftSums[i] = []int{}
		rightSums[i] = []int{}
	}

	generateSums(left, leftSums)
	generateSums(right, rightSums)

	for i := 0; i <= n; i++ {
		sort.Ints(rightSums[i])
	}

	ans := math.MaxInt32
	for i := 0; i <= n; i++ {
		for _, leftSum := range leftSums[i] {
			rightTarget := (sum - 2*leftSum) / 2
			l, r := 0, len(rightSums[n-i])-1
			for l <= r {
				mid := l + (r-l)/2
				rightSum := rightSums[n-i][mid]
				diff := sum - 2*(leftSum+rightSum)
				ans = min(ans, abs(diff))
				if diff > 0 {
					l = mid + 1
				} else {
					r = mid - 1
				}
			}
		}
	}

	return ans
}

func generateSums(nums []int, sums [][]int) {
	n := len(nums)
	for mask := 0; mask < (1 << n); mask++ {
		count := 0
		currentSum := 0
		for i := 0; i < n; i++ {
			if (mask>>i)&1 == 1 {
				count++
				currentSum += nums[i]
			}
		}
		sums[count] = append(sums[count], currentSum)
	}
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}