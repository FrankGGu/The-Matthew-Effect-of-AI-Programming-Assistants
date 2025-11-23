func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func minPartitions(s string) int {
	n := len(s)
	ans := 1
	for i := 0; i < n-1; i++ {
		freq := make([]int, 26)
		for j := 0; j <= i; j++ {
			freq[s[j]-'a']++
		}
		valid1 := true
		count1 := 0
		val1 := 0
		for j := 0; j < 26; j++ {
			if freq[j] > 0 {
				count1++
				if val1 == 0 {
					val1 = freq[j]
				} else if val1 != freq[j] {
					valid1 = false
					break
				}
			}
		}

		if !valid1 {
			ans++
			continue
		}

		freq2 := make([]int, 26)
		for j := i + 1; j < n; j++ {
			freq2[s[j]-'a']++
		}

		valid2 := true
		count2 := 0
		val2 := 0
		for j := 0; j < 26; j++ {
			if freq2[j] > 0 {
				count2++
				if val2 == 0 {
					val2 = freq2[j]
				} else if val2 != freq2[j] {
					valid2 = false
					break
				}
			}
		}

		if !valid2 {
			ans++
			continue
		}

		if count1 == 0 || count2 == 0 {
			ans++
			continue
		}
	}
	return ans
}