func magicalString(n int) int {
	if n == 0 {
		return 0
	}
	if n <= 3 {
		return 1
	}
	s := []int{1, 2, 2}
	i, j := 2, 3
	count := 1
	for j < n {
		for k := 0; k < s[i]; k++ {
			s = append(s, 3-s[len(s)-1])
			if s[len(s)-1] == 1 && j < n {
				count++
			}
			j++
			if j >= n {
				break
			}
		}
		i++
	}
	return count
}