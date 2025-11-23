import (
	"math"
)

func findBestValue(arr []int, target int) int {
	l, r := 0, 0
	sum := 0
	for _, v := range arr {
		sum += v
		if v > r {
			r = v
		}
	}

	if sum <= target {
		maxVal := 0
		for _, v := range arr {
			if v > maxVal {
				maxVal = v
			}
		}
		return maxVal
	}

	ans := 0
	minDiff := math.MaxInt32

	for l <= r {
		mid := l + (r-l)/2
		curSum := 0
		for _, v := range arr {
			if v > mid {
				curSum += mid
			} else {
				curSum += v
			}
		}

		diff := int(math.Abs(float64(curSum - target)))

		if diff < minDiff {
			minDiff = diff
			ans = mid
		} else if diff == minDiff && mid < ans {
			ans = mid
		}

		if curSum > target {
			r = mid - 1
		} else {
			l = mid + 1
		}
	}

	return ans
}