func circularArrayLoop(nums []int) bool {
	n := len(nums)

	for i := 0; i < n; i++ {
		if nums[i] == 0 {
			continue
		}

		slow, fast := i, i
		sign := nums[i] > 0

		for {
			slow = next(nums, slow)
			if nums[slow] == 0 || (nums[slow] > 0) != sign {
				break
			}

			fast = next(nums, fast)
			if nums[fast] == 0 || (nums[fast] > 0) != sign {
				break
			}
			fast = next(nums, fast)
			if nums[fast] == 0 || (nums[fast] > 0) != sign {
				break
			}

			if slow == fast {
				if slow == next(nums, slow) {
					break
				}
				return true
			}
		}

		slow = i
		sign = nums[i] > 0
		for {
			nextIndex := next(nums, slow)
			temp := nums[slow]
			nums[slow] = 0
			slow = nextIndex
			if temp > 0 != sign {
				break
			}
			if temp == 0 {
				break
			}
		}
	}

	return false
}

func next(nums []int, i int) int {
	n := len(nums)
	return ((i + nums[i]) % n + n) % n
}