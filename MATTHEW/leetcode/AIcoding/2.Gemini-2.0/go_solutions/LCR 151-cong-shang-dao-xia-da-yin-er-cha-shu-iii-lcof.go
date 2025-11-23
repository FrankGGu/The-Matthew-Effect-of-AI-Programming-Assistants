func recordLights(lights []int) []int {
	n := len(lights)
	res := make([]int, n)
	for i := 0; i < n; i++ {
		res[i] = 1
	}

	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if lights[i] == lights[j] {
				res[i]++
				res[j]++
			}
		}
	}

	return res
}