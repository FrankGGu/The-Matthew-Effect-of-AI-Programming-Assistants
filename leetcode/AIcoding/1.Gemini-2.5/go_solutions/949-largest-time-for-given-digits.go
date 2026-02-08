func largestTimeFromDigits(A []int) string {
	maxTimeInMinutes := -1
	result := ""

	p := make([]int, 4)      // To store the current permutation
	used := make([]bool, 4) // To track which digits from A have been used

	var generatePermutations func(k int)
	generatePermutations = func(k int) {
		if k == 4 {
			// A full permutation [p[0], p[1], p[2], p[3]] is formed.
			// Try to form HH:MM
			h := p[0]*10 + p[1]
			m := p[2]*10 + p[3]

			// Check if the formed time is valid
			if h >= 0 && h <= 23 && m >= 0 && m <= 59 {
				currentTimeInMinutes := h*60 + m
				if currentTimeInMinutes > max