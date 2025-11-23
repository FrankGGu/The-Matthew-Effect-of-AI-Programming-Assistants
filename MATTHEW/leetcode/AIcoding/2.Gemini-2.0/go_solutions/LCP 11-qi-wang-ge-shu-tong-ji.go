func expectNumber(scores []int) int {
	if len(scores) == 0 {
		return 0
	}
	sort(scores)
	count := 1
	for i := 1; i < len(scores); i++ {
		if scores[i] != scores[i-1] {
			count++
		}
	}
	return count
}

func sort(arr []int) {
	n := len(arr)
	for i := 0; i < n-1; i++ {
		for j := 0; j < n-i-1; j++ {
			if arr[j] > arr[j+1] {
				arr[j], arr[j+1] = arr[j+1], arr[j]
			}
		}
	}
}