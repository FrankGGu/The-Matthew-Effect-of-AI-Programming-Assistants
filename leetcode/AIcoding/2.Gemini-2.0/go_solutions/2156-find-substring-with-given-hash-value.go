func subStrHash(s string, power int, modulo int, k int, hashValue int) string {
	n := len(s)
	ans := ""
	aL := int64(0)
	for i := n - k; i < n; i++ {
		aL = (aL*int64(power) + int64(s[i]-'a'+1)) % int64(modulo)
	}
	if aL == int64(hashValue) {
		ans = s[n-k:]
	}
	pL := int64(1)
	for i := 0; i < k-1; i++ {
		pL = (pL * int64(power)) % int64(modulo)
	}
	for i := n - k - 1; i >= 0; i-- {
		aL = (aL - int64(s[i+k]-'a'+1)*pL%int64(modulo) + int64(modulo)) % int64(modulo)
		aL = (aL*int64(power) + int64(s[i]-'a'+1)) % int64(modulo)
		if aL == int64(hashValue) {
			ans = s[i : i+k]
		}
	}
	return ans
}