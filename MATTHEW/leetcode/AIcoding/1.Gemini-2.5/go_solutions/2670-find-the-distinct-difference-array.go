import "math"

func distinctDifferenceArray(nums []int) []int {
	n := len(nums)
	ans := make([]int, n)

	prefixDistincts := make([]int, n)
	currentSet := make(map[int]struct{})
	for i := 0; i < n; i++ {
		currentSet[nums[i]] = struct{}{}
		prefixDistincts[i] = len(currentSet)
	}

	suffixDistincts := make([]int, n)
	currentSet = make(map[int]struct{}) // Reset set for suffix calculation
	for i := n - 1; i >= 0; i-- {
		currentSet[nums[i]] = struct{}{}
		suffixDistincts[i] = len(currentSet)
	}

	for i := 0; i < n; i++ {
		prefixCount := prefixDistincts[i]
		suffixCount := 0
		if i+1 < n {
			suffixCount = suffixDistincts[i+1]
		}
		ans[i] = int(math.Abs(float64(prefixCount - suffixCount)))
	}

	return ans
}