func oddEvenJumps(arr []int) int {
	n := len(arr)
	odd := make([]bool, n)
	even := make([]bool, n)
	odd[n-1] = true
	even[n-1] = true
	count := 1

	for i := n - 2; i >= 0; i-- {
		oddNext := -1
		minVal := 100001
		for j := i + 1; j < n; j++ {
			if arr[j] >= arr[i] && arr[j] < minVal {
				minVal = arr[j]
				oddNext = j
			}
		}
		if oddNext != -1 {
			odd[i] = even[oddNext]
		}

		evenNext := -1
		maxVal := -1
		for j := i + 1; j < n; j++ {
			if arr[j] <= arr[i] && arr[j] > maxVal {
				maxVal = arr[j]
				evenNext = j
			}
		}

		if evenNext != -1 {
			even[i] = odd[evenNext]
		}

		if odd[i] {
			count++
		}
	}

	return count
}