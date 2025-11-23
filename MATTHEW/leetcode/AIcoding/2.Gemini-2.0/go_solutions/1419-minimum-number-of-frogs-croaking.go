func minNumberFrogs(croakOfFrogs string) int {
	croakCount := [5]int{}
	frogCount := 0
	maxFrogs := 0

	for _, c := range croakOfFrogs {
		switch c {
		case 'c':
			croakCount[0]++
			frogCount++
			if frogCount > maxFrogs {
				maxFrogs = frogCount
			}
		case 'r':
			croakCount[1]++
			croakCount[0]--
		case 'o':
			croakCount[2]++
			croakCount[1]--
		case 'a':
			croakCount[3]++
			croakCount[2]--
		case 'k':
			croakCount[4]++
			croakCount[3]--
			frogCount--
		}

		for i := 0; i < 4; i++ {
			if croakCount[i] < 0 {
				return -1
			}
		}
	}

	if frogCount != 0 {
		return -1
	}

	return maxFrogs
}