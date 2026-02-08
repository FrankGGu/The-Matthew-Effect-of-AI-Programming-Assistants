func maximumStrongPairXor(nums []int) int {
	max_xor := 0
	n := len(nums)

	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			x := nums[i]
			y := nums[j]

			// Calculate min(x, y)
			min_xy := x
			if y < x {
				min_xy = y
			}

			// Calculate abs(x - y)
			diff_xy := x - y
			if diff_xy < 0 {
				diff_xy = -diff_xy
			}

			// Check strong pair condition: abs(x - y) <= min(x, y)
			if diff_xy <= min_xy {
				current_xor := x ^ y
				if current_xor > max_xor {
					max_xor = current_xor
				}
			}
		}
	}
	return max_xor
}