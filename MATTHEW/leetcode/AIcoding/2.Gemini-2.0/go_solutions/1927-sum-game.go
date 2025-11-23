func sumGame(num string) bool {
	n := len(num)
	count := 0
	sum := 0
	for i := 0; i < n; i++ {
		if num[i] == '?' {
			if i < n/2 {
				count++
			} else {
				count--
			}
		} else {
			digit := int(num[i] - '0')
			if i < n/2 {
				sum += digit
			} else {
				sum -= digit
			}
		}
	}

	if count == 0 {
		return sum != 0
	}

	if count%2 != 0 {
		return true
	}

	return sum != count/2*9
}