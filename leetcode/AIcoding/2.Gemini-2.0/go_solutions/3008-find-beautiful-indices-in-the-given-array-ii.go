func beautifulIndices(s string, a string, b string, k int) []int {
	n := len(s)
	m1 := len(a)
	m2 := len(b)
	beautiful := []int{}

	indicesA := []int{}
	for i := 0; i <= n-m1; i++ {
		if s[i:i+m1] == a {
			indicesA = append(indicesA, i)
		}
	}

	indicesB := []int{}
	for i := 0; i <= n-m2; i++ {
		if s[i:i+m2] == b {
			indicesB = append(indicesB, i)
		}
	}

	for _, i := range indicesA {
		found := false
		for _, j := range indicesB {
			if abs(i-j) <= k {
				found = true
				break
			}
		}
		if found {
			beautiful = append(beautiful, i)
		}
	}

	return beautiful
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}