func shortestSupersequence(nums []int, queries [][]int) []int {
	freq := make(map[int]int)
	for _, num := range nums {
		freq[num]++
	}
	uniqueNums := make([]int, 0)
	for num := range freq {
		uniqueNums = append(uniqueNums, num)
	}

	result := make([]int, len(queries))
	for i, query := range queries {
		start, end := query[0], query[1]
		queryFreq := make(map[int]int)
		for j := start; j <= end; j++ {
			queryFreq[nums[j]]++
		}

		valid := true
		for _, num := range uniqueNums {
			if queryFreq[num] == 0 {
				valid = false
				break
			}
		}

		if !valid {
			result[i] = 0
			continue
		}

		minLen := end - start + 1
		count := 1

		for left := start; left <= end; left++ {
			for right := left; right <= end; right++ {
				subFreq := make(map[int]int)
				for k := left; k <= right; k++ {
					subFreq[nums[k]]++
				}

				subValid := true
				for _, num := range uniqueNums {
					if subFreq[num] == 0 {
						subValid = false
						break
					}
				}

				if subValid {
					length := right - left + 1
					if length < minLen {
						minLen = length
						count = 1
					} else if length == minLen {
						count++
					}
				}
			}
		}
		result[i] = count
	}
	return result
}