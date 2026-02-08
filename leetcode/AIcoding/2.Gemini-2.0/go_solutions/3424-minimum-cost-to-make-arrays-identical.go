import (
	"sort"
)

func minCost(nums1 []int, nums2 []int, cost []int) int64 {
	n := len(nums1)
	vals := make(map[int]bool)
	for i := 0; i < n; i++ {
		vals[nums1[i]] = true
		vals[nums2[i]] = true
	}

	uniqueVals := []int{}
	for v := range vals {
		uniqueVals = append(uniqueVals, v)
	}
	sort.Ints(uniqueVals)

	ans := int64(-1)

	for _, target := range uniqueVals {
		curCost := int64(0)
		valid := true
		for i := 0; i < n; i++ {
			if nums1[i] != target && nums2[i] != target {
				valid = false
				break
			}
			if nums1[i] != target {
				curCost += int64(cost[i])
			}
		}

		if valid {
			if ans == -1 || curCost < ans {
				ans = curCost
			}
		}
	}

	return ans
}