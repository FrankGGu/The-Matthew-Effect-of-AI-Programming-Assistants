func smallestSubarrays(nums []int) []int {
	n := len(nums)
	res := make([]int, n)
	for i := 0; i < n; i++ {
		maxOr := 0
		res[i] = 1
		for j := i; j < n; j++ {
			maxOr |= nums[j]
			curOr := 0
			for k := i; k <= j; k++ {
				curOr |= nums[k]
			}
			if curOr == maxOr {
				res[i] = j - i + 1
			}
		}

		maxOr := 0
		right := i
		for left := i; left >= 0; left-- {
			curOr := 0
			for k := left; k <= i; k++ {
				curOr |= nums[k]
			}
			if curOr > maxOr {
				maxOr = curOr
			}
		}

		maxOr = 0
		right = i
		for right < n {
			maxOr |= nums[right]
			curOr := 0
			for k := i; k <= right; k++ {
				curOr |= nums[k]
			}
			if curOr == maxOr {
				res[i] = right - i + 1
			} else if curOr > maxOr {
				res[i] = right - i + 1
			}
			right++
		}

		maxOr := 0
		right = i
		for right < n {
			currentOr := 0
			for k := i; k <= right; k++ {
				currentOr |= nums[k]
			}

			if currentOr > maxOr {
				maxOr = currentOr
				res[i] = right - i + 1
			}
			right++
		}

		maxOr = 0
		right = i
		for right < n {
			maxOr |= nums[right]
			if maxOr == maxOr | nums[i] {
				res[i] = right - i + 1
			} else {
				break
			}
			right++
		}

		maxOr := 0
		right = i
		for right < n {
			maxOr |= nums[right]

			if maxOr == 0 {
				res[i] = 1
				break
			}

			curOr := 0
			for k := i; k <= right; k++ {
				curOr |= nums[k]
			}

			if curOr == maxOr {
				res[i] = right - i + 1
			}

			right++
		}

		right = i
		maxOr = 0
		for right < n {
			maxOr |= nums[right]

			if maxOr == (maxOr | nums[i]) {
				res[i] = right - i + 1
			} else {
				break
			}
			right++
		}

		maxOr = 0
        right = i
        for right < n {
            maxOr |= nums[right]
            if maxOr == maxOr | nums[i] {
                res[i] = right - i + 1
            } else {
                break
            }
            right++
        }

        if res[i] == 1 {
            maxOr := nums[i]
            right = i + 1
            for right < n {
                maxOr |= nums[right]
                if maxOr == maxOr | nums[i] {
                    res[i] = right - i + 1
                } else {
                    break
                }
                right++
            }
        }
	}
	return res
}