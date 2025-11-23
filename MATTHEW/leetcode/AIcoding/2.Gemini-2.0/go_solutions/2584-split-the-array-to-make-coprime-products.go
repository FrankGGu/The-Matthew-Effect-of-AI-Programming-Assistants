func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func splitArray(nums []int) int {
	n := len(nums)
	right := make(map[int]int)
	left := make(map[int]int)

	for i := 0; i < n; i++ {
		num := nums[i]
		for j := 2; j*j <= num; j++ {
			if num%j == 0 {
				if _, ok := right[j]; !ok {
					right[j] = i
				}
				left[j] = i
				for num%j == 0 {
					num /= j
				}
			}
		}
		if num > 1 {
			if _, ok := right[num]; !ok {
				right[num] = i
			}
			left[num] = i
		}
	}

	maxLeft := -1
	for _, v := range left {
		maxLeft = max(maxLeft, v)
	}
	if maxLeft == -1{
		return -1
	}

	for i := 0; i < n-1; i++ {
		num := nums[i]
		currRight := -1
		for j := 2; j*j <= num; j++ {
			if num%j == 0 {
				currRight = max(currRight, right[j])
				for num%j == 0 {
					num /= j
				}
			}
		}
		if num > 1 {
			currRight = max(currRight, right[num])
		}
		if currRight == -1 {
			continue
		}

		leftGcd := 1
		for k := 0; k <= i; k++ {
			leftGcd = gcd(leftGcd, nums[k])
		}

		rightGcd := 1
		for k := i+1; k < n; k++ {
			rightGcd = gcd(rightGcd, nums[k])
		}

		ok := true
		for k := 0; k <= i; k++{
			if gcd(nums[k], rightGcd) != 1 {
				ok = false
				break
			}
		}

		for k := i+1; k < n; k++{
			if gcd(nums[k], leftGcd) != 1 {
				ok = false
				break
			}
		}

		if ok {
			return i
		}
	}

	return -1
}