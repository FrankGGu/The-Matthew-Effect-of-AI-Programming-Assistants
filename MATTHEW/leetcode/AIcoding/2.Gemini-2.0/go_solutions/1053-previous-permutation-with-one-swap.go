func prevPermOpt1(arr []int) []int {
	n := len(arr)
	for i := n - 2; i >= 0; i-- {
		if arr[i] > arr[i+1] {
			j := n - 1
			for j > i && arr[j] >= arr[i] {
				j--
			}
			for j > i && arr[j] == arr[j-1] {
				j--
			}
			arr[i], arr[j] = arr[j], arr[i]
			return arr
		}
	}
	return arr
}