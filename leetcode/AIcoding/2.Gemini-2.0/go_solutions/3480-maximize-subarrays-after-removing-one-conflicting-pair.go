func maximizeSubarrays(nums []int) int {
	n := len(nums)
	ans := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			temp := make([]int, n)
			copy(temp, nums)

			a := temp[i]
			b := temp[j]

			temp[i] = -1
			temp[j] = -1

			cur := 0
			xor := 0

			for k := 0; k < n; k++ {
				if temp[k] == -1 {
					continue
				}
				xor ^= temp[k]
				if xor == 0 {
					cur++
					xor = 0
				}
			}

			ans = max(ans, cur)

			temp = make([]int, n)
			copy(temp, nums)

			temp[i] = -1
			temp[j] = -1

			cur = 0
			xor = 0

			for k := 0; k < n; k++ {
				if temp[k] == -1 {
					continue
				}
				xor ^= temp[k]
				if xor == 0 {
					cur++
					xor = 0
				}
			}

			ans = max(ans, cur)

			temp = make([]int, n)
			copy(temp, nums)

			temp[i] = -1

			cur := 0
			xor := 0

			for k := 0; k < n; k++ {
				if temp[k] == -1 {
					continue
				}
				xor ^= temp[k]
				if xor == 0 {
					cur++
					xor = 0
				}
			}

			ans = max(ans, cur)

			temp = make([]int, n)
			copy(temp, nums)

			temp[j] = -1

			cur = 0
			xor = 0

			for k := 0; k < n; k++ {
				if temp[k] == -1 {
					continue
				}
				xor ^= temp[k]
				if xor == 0 {
					cur++
					xor = 0
				}
			}

			ans = max(ans, cur)
		}
	}

	cur := 0
	xor := 0

	for k := 0; k < n; k++ {
		xor ^= nums[k]
		if xor == 0 {
			cur++
			xor = 0
		}
	}

	ans = max(ans, cur)

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}