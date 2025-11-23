func smallestLexicographical(n int, k int) []int {
	res := make([]int, n)
	for i := n - 1; i >= 0; i-- {
		for j := 1; j <= n; j++ {
			if k-j >= 0 {
				count := 0
				valid := true
				for l := 0; l < n; l++ {
					if res[l] == j {
						valid = false
						break
					}
					if res[l] != 0 {
						count++
					}
				}
				if valid && (n-count)*n/2 >= k-j {
					res[i] = j
					k -= j
					break
				}
			}
		}
	}
	return res
}