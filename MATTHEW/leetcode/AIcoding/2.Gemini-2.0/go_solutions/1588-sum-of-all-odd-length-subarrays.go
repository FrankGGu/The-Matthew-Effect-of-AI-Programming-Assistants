func sumOddLengthSubarrays(arr []int) int {
	n := len(arr)
	sum := 0
	for i := 0; i < n; i++ {
		for length := 1; i+length <= n; length += 2 {
			for j := i; j < i+length; j++ {
				sum += arr[j]
			}
		}
	}
	return sum
}