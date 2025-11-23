func maximumSum(nums []int, remove int) int {
	maxSum := -1 << 62
	for i := 0; i < len(nums); i++ {
		currentSum := 0
		for j := i; j < len(nums); j++ {
			if nums[j] == remove {
				continue
			}
			currentSum += nums[j]
			if currentSum > maxSum {
				maxSum = currentSum
			}
		}
	}

	prefixSum := make([]int, len(nums)+1)
	for i := 0; i < len(nums); i++ {
		prefixSum[i+1] = prefixSum[i] + nums[i]
	}

	removeIndices := []int{}
	for i := 0; i < len(nums); i++ {
		if nums[i] == remove {
			removeIndices = append(removeIndices, i)
		}
	}

	if len(removeIndices) == 0 {
		maxSum = 0
		for _, num := range nums {
			if num > 0 {
				maxSum = -1 << 62
				break
			}
		}
		if maxSum == 0 {
			for _, num := range nums {
				if num > maxSum {
					maxSum = num
				}
			}
			return maxSum
		}
	}

	for i := 0; i < len(removeIndices); i++ {
		index := removeIndices[i]
		currentSum := 0
		for j := 0; j < len(nums); j++ {
			if j == index {
				continue
			}
			currentSum += nums[j]
			if currentSum > maxSum {
				maxSum = currentSum
			}
			if currentSum < 0 {
				currentSum = 0
			}
		}

	}

	currentSum := 0
    maxSoFar := -1 << 62

    for i := 0; i < len(nums); i++ {
        if nums[i] == remove {
            currentSum = 0
        } else {
            currentSum += nums[i]
            if currentSum > maxSoFar {
                maxSoFar = currentSum
            }
            if currentSum < 0 {
                currentSum = 0
            }
        }
    }

    if maxSoFar == -1 << 62 {
        maxSoFar = 0
        hasPositive := false
        for _, num := range nums {
            if num > 0 && num != remove {
                hasPositive = true
                break
            }
        }

        if !hasPositive {
            minNegative := -1 << 62
            for _, num := range nums {
                if num > minNegative && num != remove {
                    minNegative = num
                }
            }
            if minNegative != -1 << 62 {
                maxSoFar = minNegative
            } else {
                maxSoFar = 0
            }
        }
    }

	return maxSoFar
}