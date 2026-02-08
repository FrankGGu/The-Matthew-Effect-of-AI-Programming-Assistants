func check(arr []int) bool {
	if len(arr) <= 2 {
		return true
	}
	minVal := arr[0]
	maxVal := arr[0]
	seen := make(map[int]bool)
	for _, num := range arr {
		minVal = min(minVal, num)
		maxVal = max(maxVal, num)
		seen[num] = true
	}

	if (maxVal-minVal)%(len(arr)-1) != 0 {
		return false
	}
	diff := (maxVal - minVal) / (len(arr) - 1)

	if diff == 0 {
		return len(seen) == 1
	}

	curr := minVal
	for i := 0; i < len(arr); i++ {
		if !seen[curr] {
			return false
		}
		curr += diff
	}

	return true
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func arithmeticSubarrays(nums []int, l []int, r []int) []bool {
	result := make([]bool, len(l))
	for i := 0; i < len(l); i++ {
		subArr := nums[l[i] : r[i]+1]
		temp := make([]int, len(subArr))
		copy(temp, subArr)
		result[i] = check(temp)
	}
	return result
}