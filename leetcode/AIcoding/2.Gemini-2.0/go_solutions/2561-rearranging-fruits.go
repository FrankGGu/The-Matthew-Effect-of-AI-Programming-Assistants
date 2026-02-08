func minCost(basket1 []int, basket2 []int) int64 {
	cnt := make(map[int]int)
	for _, x := range basket1 {
		cnt[x]++
	}
	for _, x := range basket2 {
		cnt[x]--
	}
	var nums []int
	for x, c := range cnt {
		if c == 0 {
			continue
		}
		if c%2 != 0 {
			return -1
		}
		for i := 0; i < abs(c/2); i++ {
			nums = append(nums, x)
		}
	}
	sort.Ints(nums)
	n := len(nums)
	ans := int64(0)
	minVal := math.MaxInt32
	for x := range cnt {
		if x < minVal {
			minVal = x
		}
	}
	for i := 0; i < n/2; i++ {
		ans += int64(min(nums[i], minVal*2))
	}
	return ans
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

import (
	"sort"
	"math"
)