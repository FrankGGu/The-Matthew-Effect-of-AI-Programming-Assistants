func kthSmallestPath(destination []int, k int) string {
	vertical := destination[0]
	horizontal := destination[1]
	total := vertical + horizontal
	result := ""
	for i := 0; i < total; i++ {
		if horizontal > 0 {
			combinations := 1
			n := vertical + horizontal - 1
			r := vertical
			if r > n-r {
				r = n - r
			}
			for j := 0; j < r; j++ {
				combinations = combinations * (n - j) / (j + 1)
			}
			if k <= combinations {
				result += "H"
				horizontal--
			} else {
				result += "V"
				vertical--
				k -= combinations
			}
		} else {
			result += "V"
			vertical--
		}
	}
	return result
}