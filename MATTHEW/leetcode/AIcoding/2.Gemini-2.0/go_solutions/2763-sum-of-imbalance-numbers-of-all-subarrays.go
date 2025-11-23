func sumImbalanceNumbers(nums []int) int {
	n := len(nums)
	res := 0
	for i := 0; i < n; i++ {
		for j := i; j < n; j++ {
			sub := nums[i : j+1]
			if len(sub) <= 1 {
				continue
			}
			sorted := make([]int, len(sub))
			copy(sorted, sub)
			sort(sorted)
			imbalance := 0
			for k := 1; k < len(sorted); k++ {
				if sorted[k]-sorted[k-1] > 1 {
					imbalance++
				}
			}
			res += imbalance
		}
	}
	return res
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