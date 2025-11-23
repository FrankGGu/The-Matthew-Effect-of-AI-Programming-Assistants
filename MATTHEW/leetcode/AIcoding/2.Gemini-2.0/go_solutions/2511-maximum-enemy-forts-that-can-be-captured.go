func captureForts(forts []int) int {
	maxCaptured := 0
	lastFort := -1

	for i := 0; i < len(forts); i++ {
		if forts[i] != 0 {
			if lastFort != -1 && forts[i] != forts[lastFort] {
				captured := 0
				valid := true
				for j := lastFort + 1; j < i; j++ {
					if forts[j] != 0 {
						valid = false
						break
					}
					captured++
				}
				if valid {
					if captured > maxCaptured {
						maxCaptured = captured
					}
				}
			}
			lastFort = i
		}
	}

	return maxCaptured
}