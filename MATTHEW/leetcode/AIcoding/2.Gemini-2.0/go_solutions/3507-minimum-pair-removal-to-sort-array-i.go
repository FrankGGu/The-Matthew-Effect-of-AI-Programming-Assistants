func minPairSum(nums []int) int {
	n := len(nums)
	maxSum := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			sum := nums[i] + nums[j]
			count := 0
			temp := make([]int, n)
			copy(temp, nums)
			temp[i] = -1
			temp[j] = -1
			for k := 0; k < n; k++ {
				if temp[k] != -1 {
					count++
				}
			}
			if count == 0 {
				if sum > maxSum {
					maxSum = sum
				}
			}
		}
	}

	tempNums := make([]int, len(nums))
	copy(tempNums, nums)

	for {
		changed := false
		minSum := -1
		minI := -1
		minJ := -1

		used := make([]bool, len(tempNums))

		for i := 0; i < len(tempNums); i++ {
			if used[i] {
				continue
			}
			for j := i+1; j < len(tempNums); j++ {
				if used[j] {
					continue
				}

				sum := tempNums[i] + tempNums[j]

				if minSum == -1 || sum < minSum {
					minSum = sum
					minI = i
					minJ = j
				}
			}
		}

		if minSum == -1 {
			break
		}

		if minSum > maxSum {
			maxSum = minSum
		}

		used[minI] = true
		used[minJ] = true

		count := 0
		for i := 0; i < len(used); i++ {
			if !used[i] {
				count++
			}
		}

		if count == 0 {
			break
		}

		tempNums2 := make([]int, 0)
		for i := 0; i < len(tempNums); i++ {
			if !used[i] {
				tempNums2 = append(tempNums2, tempNums[i])
			}
		}

		tempNums = make([]int, len(tempNums2))
		copy(tempNums, tempNums2)

	}

	return maxSum
}