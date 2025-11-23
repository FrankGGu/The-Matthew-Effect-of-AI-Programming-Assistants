func customSortString(order string, s string) string {
	orderMap := make(map[rune]int)
	for i, r := range order {
		orderMap[r] = i
	}

	sRune := []rune(s)
	sort.Slice(sRune, func(i, j int) bool {
		iVal, iOk := orderMap[sRune[i]]
		jVal, jOk := orderMap[sRune[j]]

		if iOk && jOk {
			return iVal < jVal
		} else if iOk {
			return true
		} else if jOk {
			return false
		} else {
			return sRune[i] < sRune[j]
		}
	})

	return string(sRune)
}