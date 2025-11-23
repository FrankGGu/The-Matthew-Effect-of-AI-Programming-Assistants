func countTriplets(arr []int) int {
	n := len(arr)
	count := 0
	for i := 0; i < n-1; i++ {
		xor := 0
		for j := i; j < n; j++ {
			xor ^= arr[j]
			if xor == 0 {
				count += j - i
			} else {
				for k := j + 1; k < n; k++ {
					xor2 := 0
					for l := j + 1; l <= k; l++ {
						xor2 ^= arr[l]
					}
					if xor^xor2 == 0 {
						count++
					}
				}
			}
		}
	}
	return count
}