func threeEqualParts(arr []int) []int {
	n := len(arr)
	ones := 0
	for _, num := range arr {
		if num == 1 {
			ones++
		}
	}
	if ones%3 != 0 {
		return []int{-1, -1}
	}
	if ones == 0 {
		return []int{0, n - 1}
	}

	k := ones / 3
	firstGroupOnes := 0
	firstGroupStart := -1
	for i := 0; i < n; i++ {
		if arr[i] == 1 {
			firstGroupOnes++
			if firstGroupOnes == 1 {
				firstGroupStart = i
			}
			if firstGroupOnes == k {
				break
			}
		}
	}

	secondGroupOnes := 0
	secondGroupStart := -1
	for i := firstGroupStart + 1; i < n; i++ {
		if arr[i] == 1 {
			secondGroupOnes++
			if secondGroupOnes == 1 {
				secondGroupStart = i
			}
			if secondGroupOnes == k {
				break
			}
		}
	}

	thirdGroupOnes := 0
	thirdGroupStart := -1
	for i := secondGroupStart + 1; i < n; i++ {
		if arr[i] == 1 {
			thirdGroupOnes++
			if thirdGroupOnes == 1 {
				thirdGroupStart = i
			}
			if thirdGroupOnes == k {
				break
			}
		}
	}

	len := n - thirdGroupStart
	if firstGroupStart+len > secondGroupStart || secondGroupStart+len > thirdGroupStart {
		return []int{-1, -1}
	}

	for i := 0; i < len; i++ {
		if arr[firstGroupStart+i] != arr[secondGroupStart+i] || arr[firstGroupStart+i] != arr[thirdGroupStart+i] {
			return []int{-1, -1}
		}
	}

	return []int{firstGroupStart + len - 1, secondGroupStart + len}
}