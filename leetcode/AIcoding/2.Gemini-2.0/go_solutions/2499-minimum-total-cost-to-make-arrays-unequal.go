import (
	"sort"
)

func minimumTotalCost(nums1 []int, nums2 []int) int64 {
	n := len(nums1)
	same := 0
	counts := make(map[int]int)
	for i := 0; i < n; i++ {
		if nums1[i] == nums2[i] {
			same++
			counts[nums1[i]]++
		}
	}

	if same == 0 {
		return 0
	}

	maxCount := 0
	maxVal := 0
	for val, count := range counts {
		if count > maxCount {
			maxCount = count
			maxVal = val
		}
	}

	cost := int64(same)
	if maxCount <= same-maxCount {
		return cost
	}

	diff := maxCount - (same - maxCount)

	indices := []int{}
	for i := 0; i < n; i++ {
		if nums1[i] == nums2[i] && nums1[i] != maxVal {
			indices = append(indices, i)
		}
	}

	notSameIndices := []int{}
	for i := 0; i < n; i++ {
		if nums1[i] != nums2[i] {
			notSameIndices = append(notSameIndices, i)
		}
	}

	if len(notSameIndices) >= diff{
		return cost + int64(diff) * 2
	}

	if len(indices) + len(notSameIndices) < diff{
		return -1
	}

	return cost + int64(diff) * 2
}

func main() {}