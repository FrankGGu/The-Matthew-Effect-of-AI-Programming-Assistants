func numberOfGoodPartitions(nums []int) int {
	mod := int(1e9 + 7)
	n := len(nums)
	lastOccurrence := make(map[int]int)
	for i, num := range nums {
		lastOccurrence[num] = i
	}

	maxIndex := 0
	for i := 0; i < n; i++ {
		maxIndex = max(maxIndex, lastOccurrence[nums[i]])
		if i == maxIndex && i != n-1 {
			maxIndex++
		}
	}

	if maxIndex == 0 {
		return 1
	}

	partitions := 0
	for i := 0; i < n; {
		partitions++
		i = maxIndex
		if i < n && i != n-1{
			maxIndex = i+1
			for j := i; j < n; j++ {
				maxIndex = max(maxIndex, lastOccurrence[nums[j]])
				if j == maxIndex && j != n-1 {
					maxIndex++
				}
			}
		}else{
			break
		}

	}

	if partitions > 0{
		partitions = 0
		maxIndex = 0
		for i := 0; i < n; {
			maxIndex = max(maxIndex, lastOccurrence[nums[i]])
			if i == maxIndex {
				partitions++
				if i < n-1{
					i++
				}else{
					break
				}

			}else{
				i++
			}

		}

	}

	if partitions == 0{
		return 0
	}

	ans := 1
	for i := 1; i < partitions; i++ {
		ans = (ans * 2) % mod
	}

	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}