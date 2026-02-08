func equalProduct(nums []int) int {
	n := len(nums)
	prefixProducts := make([]int, n+1)
	prefixProducts[0] = 1
	for i := 0; i < n; i++ {
		prefixProducts[i+1] = prefixProducts[i] * nums[i]
	}

	maxLen := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			for k := j + 1; k < n; k++ {
				for l := k + 1; l < n; l++ {
					len1 := j - i + 1
					len2 := l - k + 1
					if len1 == len2 {
						prod1 := 1
						for m := i; m <= j; m++ {
							prod1 *= nums[m]
						}
						prod2 := 1
						for m := k; m <= l; m++ {
							prod2 *= nums[m]
						}
						if prod1 == prod2 {
							if len1 > maxLen {
								maxLen = len1
							}
						}
					}
				}
			}
		}
	}
	return maxLen * 2
}