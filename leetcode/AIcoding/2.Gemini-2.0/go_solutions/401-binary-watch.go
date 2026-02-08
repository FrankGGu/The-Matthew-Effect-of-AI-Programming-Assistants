func readBinaryWatch(turnedOn int) []string {
	result := []string{}
	for h := 0; h < 12; h++ {
		for m := 0; m < 60; m++ {
			if bits(h) + bits(m) == turnedOn {
				result = append(result, formatTime(h, m))
			}
		}
	}
	return result
}

func bits(n int) int {
	count := 0
	for n > 0 {
		n &= (n - 1)
		count++
	}
	return count
}

func formatTime(h, m int) string {
	if m < 10 {
		return string([]byte{byte('0' + h/10), byte('0' + h%10), ':', '0', byte('0' + m)})
	} else {
		return string([]byte{byte('0' + h/10), byte('0' + h%10), ':', byte('0' + m/10), byte('0' + m%10)})

	}
}