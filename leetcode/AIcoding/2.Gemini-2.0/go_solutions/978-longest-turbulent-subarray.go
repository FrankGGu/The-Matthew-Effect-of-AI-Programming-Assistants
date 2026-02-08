func maxTurbulenceSize(arr []int) int {
	n := len(arr)
	if n < 2 {
		return n
	}
	maxLen := 1
	l := 0
	for i := 1; i < n; i++ {
		if i == 1 {
			if arr[i] == arr[i-1] {
				l = 1
			}
		} else {
			if (arr[i-2] < arr[i-1] && arr[i-1] > arr[i]) || (arr[i-2] > arr[i-1] && arr[i-1] < arr[i]) {
			} else {
				if arr[i] == arr[i-1] {
					l = i + 1
				} else {
					l = i
				}
			}
		}
		maxLen = max(maxLen, i-l+1)
	}
	return maxLen
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}