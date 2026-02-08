import (
	"sort"
)

func rangeSum(nums []int, n int, left int, right int) int {
	sums := []int{}
	for i := 0; i < n; i++ {
		currentSum := 0
		for j := i; j < n; j++ {
			currentSum += nums[j]
			sums = append(sums, currentSum)
		}
	}
	sort.Ints(sums)
	totalSum := 0
	for i := left - 1; i < right; i++ {
		totalSum = (totalSum + sums[i]) % 1000000007
	}
	return totalSum
}