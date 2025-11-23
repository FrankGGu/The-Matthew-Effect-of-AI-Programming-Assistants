func minimumBuckets(hamsters string) int {
	n := len(hamsters)
	buckets := 0
	i := 0
	for i < n {
		if hamsters[i] == 'H' {
			if i > 0 && hamsters[i-1] == 'B' {
				i++
			} else if i < n-1 && hamsters[i+1] == '.' {
				buckets++
				i += 2
			} else if i > 0 && hamsters[i-1] == '.' {
				buckets++
				i++
			} else {
				return -1
			}
		} else {
			i++
		}
	}
	return buckets
}