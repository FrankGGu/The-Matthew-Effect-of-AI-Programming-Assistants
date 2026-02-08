import (
	"sort"
)

func minAbsoluteSumDifference(nums1 []int, nums2 []int) int {
	n := len(nums1)
	sortedNums1 := make([]int, n)
	copy(sortedNums1, nums1)
	sort.Ints(sortedNums1)
	sum := 0
	maxDiffChange := 0
	for i := 0; i < n; i++ {
		diff := abs(nums1[i] - nums2[i])
		sum = (sum + diff) % 1000000007
		j := sort.SearchInts(sortedNums1, nums2[i])
		if j < n {
			maxDiffChange = max(maxDiffChange, diff-abs(sortedNums1[j]-nums2[i]))
		}
		if j > 0 {
			maxDiffChange = max(maxDiffChange, diff-abs(sortedNums1[j-1]-nums2[i]))
		}
	}
	return (sum - maxDiffChange + 1000000007) % 1000000007
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}