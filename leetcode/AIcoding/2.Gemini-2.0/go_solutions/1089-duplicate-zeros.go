func duplicateZeros(arr []int) {
	n := len(arr)
	zeros := 0
	for i := 0; i < n; i++ {
		if arr[i] == 0 {
			zeros++
		}
	}

	for i := n - 1; i >= 0; i-- {
		if arr[i] == 0 {
			if i+zeros < n {
				arr[i+zeros] = 0
			}
			zeros--
			if i+zeros < n {
				arr[i+zeros] = 0
			}
		} else {
			if i+zeros < n {
				arr[i+zeros] = arr[i]
			}
		}
	}
}