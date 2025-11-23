func getSmallestString(s string, k int) string {
	sBytes := []byte(s)
	n := len(sBytes)

	for i := 0; i < n; i++ {
		if k == 0 {
			break
		}

		opsNeeded := int(sBytes[i] - 'a')

		if opsNeeded == 0 {
			continue
		}

		if k >= opsNeeded {
			sBytes[i] = 'a'
			k -= opsNeeded
		} else {
			sBytes[i] = sBytes[i] - byte(k)
			k = 0
			break
		}
	}

	return string(sBytes)
}