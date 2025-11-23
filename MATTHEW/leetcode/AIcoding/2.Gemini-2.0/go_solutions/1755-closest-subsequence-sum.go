import (
	"sort"
)

func minAbsDifference(nums []int, goal int) int {
	n := len(nums)
	left := nums[:n/2]
	right := nums[n/2:]

	leftSums := getSubsequenceSums(left)
	rightSums := getSubsequenceSums(right)

	sort.Ints(rightSums)

	minDiff := abs(goal)

	for _, leftSum := range leftSums {
		target := goal - leftSum
		l, r := 0, len(rightSums)-1
		for l <= r {
			mid := l + (r-l)/2
			diff := leftSum + rightSums[mid] - goal
			minDiff = min(minDiff, abs(diff))
			if rightSums[mid] < target {
				l = mid + 1
			} else {
				r = mid - 1
			}
		}
	}

	return minDiff
}

func getSubsequenceSums(nums []int) []int {
	sums := make([]int, 0)
	sums = append(sums, 0)
	for _, num := range nums {
		size := len(sums)
		for i := 0; i < size; i++ {
			sums = append(sums, sums[i]+num)
		}
	}
	return sums
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