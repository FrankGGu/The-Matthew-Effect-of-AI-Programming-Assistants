func maximumSwap(num int) int {
	s := []byte(strconv.Itoa(num))
	n := len(s)
	maxIndex := n - 1
	index1, index2 := -1, -1

	for i := n - 2; i >= 0; i-- {
		if s[i] < s[maxIndex] {
			index1 = i
			index2 = maxIndex
		} else if s[i] > s[maxIndex] {
			maxIndex = i
		}
	}

	if index1 == -1 {
		return num
	}

	s[index1], s[index2] = s[index2], s[index1]

	res, _ := strconv.Atoi(string(s))
	return res
}