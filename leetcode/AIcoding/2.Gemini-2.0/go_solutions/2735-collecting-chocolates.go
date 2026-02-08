import (
	"math"
)

func minCost(nums []int, cost int) int64 {
	n := len(nums)
	minVal := math.MaxInt32
	for _, num := range nums {
		if num < minVal {
			minVal = num
		}
	}

	ans := int64(math.MaxInt64)
	for start := 0; start < n; start++ {
		cur := make([]int, n)
		copy(cur, nums)
		curCost := int64(0)
		ops := 0
		for i := 0; i < n; i++ {
			if cur[i] == minVal {
				continue
			}
			diff := cur[i] - minVal
			ops += diff
			curCost += int64(diff) * int64(cost)
		}
		if int64(ops) < ans {
			ans = curCost
		}
	}

	for target := minVal; target <= minVal+100; target++ {
		curCost := int64(0)
		for i := 0; i < n; i++ {
			if nums[i] == target {
				continue
			}
			diff := int(math.Abs(float64(nums[i] - target)))
			curCost += int64(diff) * int64(cost)
		}
		if curCost < ans {
			ans = curCost
		}
	}

	return ans
}