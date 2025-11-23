import (
	"sort"
)

func minOperations(nums []int) int {
	n := len(nums)
	uniqueNums := make([]int, 0)
	seen := make(map[int]bool)
	for _, num := range nums {
		if !seen[num] {
			uniqueNums = append(uniqueNums, num)
			seen[num] = true
		}
	}
	sort.Ints(uniqueNums)

	ans := n
	for i := 0; i < len(uniqueNums); i++ {
		left := uniqueNums[i]
		right := left + n - 1
		j := sort.SearchInts(uniqueNums, right+1)
		count := j - i
		ans = min(ans, n-count)
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}