import "strconv"

func divisorSubstrings(num int, k int) int {
	s := strconv.Itoa(num)
	n := len(s)
	count := 0
	for i := 0; i <= n-k; i++ {
		sub := s[i : i+k]
		subNum, _ := strconv.Atoi(sub)
		if subNum != 0 && num%subNum == 0 {
			count++
		}
	}
	return count
}