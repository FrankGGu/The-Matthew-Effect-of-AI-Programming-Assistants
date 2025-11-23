func beautifulIndices(s string, a string, b string, k int) []int {
	n := len(s)
	m1 := len(a)
	m2 := len(b)
	indicesA := []int{}
	indicesB := []int{}

	for i := 0; i <= n-m1; i++ {
		if s[i:i+m1] == a {
			indicesA = append(indicesA, i)
		}
	}

	for i := 0; i <= n-m2; i++ {
		if s[i:i+m2] == b {
			indicesB = append(indicesB, i)
		}
	}

	result := []int{}
	for _, i := range indicesA {
		found := false
		for _, j := range indicesB {
			if abs(i-j) <= k {
				found = true
				break
			}
		}
		if found {
			result = append(result, i)
		}
	}

	return result
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}