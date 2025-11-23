func getDistances(arr []int) []int64 {
	indices := make(map[int][]int)
	for i, num := range arr {
		indices[num] = append(indices[num], i)
	}

	result := make([]int64, len(arr))
	for i, num := range arr {
		var sum int64
		for _, idx := range indices[num] {
			sum += abs(int64(i - idx))
		}
		result[i] = sum
	}

	return result
}

func abs(x int64) int64 {
	if x < 0 {
		return -x
	}
	return x
}