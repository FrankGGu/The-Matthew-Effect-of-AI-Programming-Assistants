func numberOfUniqueGoodSubsequences(s string) int {
	n := len(s)
	ends0 := 0
	ends1 := 0
	mod := 1000000007
	for i := 0; i < n; i++ {
		if s[i] == '0' {
			ends0 = (ends0 + ends1) % mod
		} else {
			ends1 = (ends0 + ends1 + 1) % mod
		}
	}
	if ends0 > 0 && ends1 > 0 && s[0] == '0'{
		return (ends0 + ends1 + 1)%mod
	}
	if ends0 > 0 && ends1 > 0 && s[0] == '1'{
		return (ends0 + ends1 )%mod
	}
	if ends0 > 0{
		hasZero := false
		for i := 0; i < n; i++ {
			if s[i] == '0' {
				hasZero = true
				break
			}
		}
		if hasZero {
			return (ends0 + 1) % mod
		} else {
			return ends0 % mod
		}
	}

	if ends1 > 0{
		return ends1 % mod
	}

	hasZero := false
		for i := 0; i < n; i++ {
			if s[i] == '0' {
				hasZero = true
				break
			}
		}
		if hasZero {
			return 1
		} else {
			return 0
		}

}