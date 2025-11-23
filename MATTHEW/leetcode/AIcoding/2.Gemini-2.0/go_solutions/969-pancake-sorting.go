func pancakeSort(arr []int) []int {
	n := len(arr)
	res := []int{}
	for i := n; i > 1; i-- {
		maxIndex := 0
		for j := 1; j < i; j++ {
			if arr[j] > arr[maxIndex] {
				maxIndex = j
			}
		}
		if maxIndex != i-1 {
			if maxIndex != 0 {
				res = append(res, maxIndex+1)
				reverse(arr, maxIndex+1)
			}
			res = append(res, i)
			reverse(arr, i)
		}
	}
	return res
}

func reverse(arr []int, k int) {
	for i := 0; i < k/2; i++ {
		arr[i], arr[k-i-1] = arr[k-i-1], arr[i]
	}
}