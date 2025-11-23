func canBeEqual(s1 string, s2 string) bool {
	if s1 == s2 {
		return true
	}

	if s1[0] == s2[0] && s1[1] == s2[1] && s1[2] == s2[2] && s1[3] == s2[3] {
		return true
	}

	temp := []byte(s1)

	temp[0], temp[2] = temp[2], temp[0]
	if string(temp) == s2 {
		return true
	}
	temp = []byte(s1)
	temp[1], temp[3] = temp[3], temp[1]
	if string(temp) == s2 {
		return true
	}

	temp = []byte(s1)
	temp[0], temp[2] = temp[2], temp[0]
	temp[1], temp[3] = temp[3], temp[1]
	if string(temp) == s2 {
		return true
	}

	temp = []byte(s1)
	temp[1], temp[3] = temp[3], temp[1]
	temp[0], temp[2] = temp[2], temp[0]
	if string(temp) == s2 {
		return true
	}

	return false
}