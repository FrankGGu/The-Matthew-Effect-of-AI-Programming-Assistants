func checkInclusion(s1 string, s2 string) bool {
	n1, n2 := len(s1), len(s2)
	if n1 > n2 {
		return false
	}

	count1 := make([]int, 26)
	count2 := make([]int, 26)

	for i := 0; i < n1; i++ {
		count1[s1[i]-'a']++
		count2[s2[i]-'a']++
	}

	if matches(count1, count2) {
		return true
	}

	for i := n1; i < n2; i++ {
		count2[s2[i-n1]-'a']--
		count2[s2[i]-'a']++
		if matches(count1, count2) {
			return true
		}
	}

	return false
}

func matches(count1, count2 []int) bool {
	for i := 0; i < 26; i++ {
		if count1[i] != count2[i] {
			return false
		}
	}
	return true
}