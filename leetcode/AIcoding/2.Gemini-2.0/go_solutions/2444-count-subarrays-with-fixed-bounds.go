func countSubarrays(nums []int, minK int, maxK int) int64 {
	var res int64
	n := len(nums)
	leftBound := -1
	minPos := -1
	maxPos := -1

	for i := 0; i < n; i++ {
		if nums[i] < minK || nums[i] > maxK {
			leftBound = i
			minPos = -1
			maxPos = -1
		}

		if nums[i] == minK {
			minPos = i
		}

		if nums[i] == maxK {
			maxPos = i
		}

		if minPos != -1 && maxPos != -1 {
			res += int64(min(minPos, maxPos) - leftBound)
		}
	}

	return res
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func main() {}