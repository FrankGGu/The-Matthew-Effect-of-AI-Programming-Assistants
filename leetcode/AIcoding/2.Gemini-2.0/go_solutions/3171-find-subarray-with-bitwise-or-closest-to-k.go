func findSubarrayWithBitwiseORClosestToK(arr []int, k int) int {
	n := len(arr)
	ans := n
	closest := -1
	for i := 0; i < n; i++ {
		orVal := 0
		for j := i; j < n; j++ {
			orVal |= arr[j]
			diff := abs(orVal - k)
			if closest == -1 || diff < abs(closest - k) {
				closest = orVal
				ans = j - i + 1
			} else if diff == abs(closest - k) && j - i + 1 < ans {
				ans = j - i + 1
			}
		}
	}
	return ans
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}