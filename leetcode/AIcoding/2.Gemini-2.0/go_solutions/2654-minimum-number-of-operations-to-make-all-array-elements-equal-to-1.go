func minOperations(nums []int) int {
	n := len(nums)
	ones := 0
	for _, num := range nums {
		if num == 1 {
			ones++
		}
	}
	if ones > 0 {
		return n - ones
	}
	minOps := int(1e9)
	for i := 0; i < n; i++ {
		gcd := nums[i]
		for j := i + 1; j < n; j++ {
			gcd = findGCD(gcd, nums[j])
			if gcd == 1 {
				minOps = min(minOps, j-i)
				break
			}
		}
	}
	if minOps == int(1e9) {
		return -1
	}
	return minOps + n - 1
}

func findGCD(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}