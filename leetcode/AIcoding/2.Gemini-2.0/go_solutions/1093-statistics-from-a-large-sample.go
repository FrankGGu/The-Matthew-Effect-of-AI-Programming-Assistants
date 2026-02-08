import "sort"

func sampleStats(count []int) []float64 {
	n := 0
	for _, c := range count {
		n += c
	}

	min := -1
	max := -1
	sum := 0.0
	mode := 0
	maxCount := 0

	for i, c := range count {
		if c > 0 {
			if min == -1 {
				min = i
			}
			max = i
			sum += float64(i * c)
			if c > maxCount {
				maxCount = c
				mode = i
			}
		}
	}

	mean := sum / float64(n)

	median := 0.0
	if n%2 == 1 {
		k := (n + 1) / 2
		curr := 0
		for i, c := range count {
			curr += c
			if curr >= k {
				median = float64(i)
				break
			}
		}
	} else {
		k1 := n / 2
		k2 := k1 + 1
		v1 := -1
		v2 := -1
		curr := 0
		for i, c := range count {
			curr += c
			if v1 == -1 && curr >= k1 {
				v1 = i
			}
			if curr >= k2 {
				v2 = i
				break
			}
		}
		median = float64(v1+v2) / 2.0
	}

	return []float64{float64(min), float64(max), mean, median, float64(mode)}
}