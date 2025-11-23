import "strconv"

func digitCount(num string) bool {
	counts := make(map[int]int)
	for i := 0; i < len(num); i++ {
		digit, _ := strconv.Atoi(string(num[i]))
		counts[digit]++
	}

	for i := 0; i < len(num); i++ {
		expected, _ := strconv.Atoi(string(num[i]))
		if counts[i] != expected {
			return false
		}
	}

	return true
}