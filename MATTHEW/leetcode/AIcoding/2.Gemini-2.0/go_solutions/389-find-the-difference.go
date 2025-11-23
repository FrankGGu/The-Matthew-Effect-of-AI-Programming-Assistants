func findTheDifference(s string, t string) byte {
	sumS := 0
	sumT := 0
	for i := 0; i < len(s); i++ {
		sumS += int(s[i])
	}
	for i := 0; i < len(t); i++ {
		sumT += int(t[i])
	}
	return byte(sumT - sumS)
}