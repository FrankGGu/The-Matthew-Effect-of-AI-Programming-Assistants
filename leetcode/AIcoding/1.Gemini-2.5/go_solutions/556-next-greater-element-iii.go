func nextGreaterElement(n int) int {
	s := strconv.Itoa(n)
	digits := make([]int, len(s))
	for i, r := range s {
		digits[i] = int(r - '0')
	}

	//