func longestMountain(arr []int) int {
	n := len(arr)
	if n < 3 {
		return 0
	}
	ans := 0
	for i := 1; i < n-1; i++ {
		if arr[i] > arr[i-1] && arr[i] > arr[i+1] {
			left := i - 1
			right := i + 1
			for left > 0 && arr[left] > arr[left-1] {
				left--
			}
			for right < n-1 && arr[right] > arr[right+1] {
				right++
			}
			ans = max(ans, right-left+1)
		}
	}
	return ans
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}