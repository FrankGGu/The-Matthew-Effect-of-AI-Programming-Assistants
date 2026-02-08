func countTime(time string) int {
	hours := 0
	h1 := time[0]
	h2 := time[1]

	if h1 == '?' && h2 == '?' {
		hours = 24
	} else if h1 == '?' {
		if h2 >= '0' && h2 <= '3' {
			hours = 3
		} else {
			hours = 2
		}
	} else if h2 == '?' {
		if h1 == '0' || h1 == '1' {
			hours = 10
		} else { // h1 == '2'
			hours = 4
		}
	} else {
		hVal := int((h1-'0')*10 + (h2-'0'))
		if hVal >= 0 && hVal <= 23 {
			hours = 1
		} else {
			hours = 0
		}
	}

	minutes := 0
	m1 := time[3]
	m2 := time[4]

	if m1 == '?' && m2 == '?' {
		minutes = 60
	} else if m1 == '?' {
		minutes = 6
	} else if m2 == '?' {
		minutes = 10
	} else {
		mVal := int((m1-'0')*10 + (m2-'0'))
		if mVal >= 0 && mVal <= 59 {
			minutes = 1
		} else {
			minutes = 0
		}
	}

	return hours * minutes
}