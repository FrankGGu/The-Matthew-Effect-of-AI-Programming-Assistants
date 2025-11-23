func gcdOfStrings(str1 string, str2 string) string {
	if str1+str2 != str2+str1 {
		return ""
	}

	len1 := len(str1)
	len2 := len(str2)

	g := gcd(len1, len2)

	return str1[:g]
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}