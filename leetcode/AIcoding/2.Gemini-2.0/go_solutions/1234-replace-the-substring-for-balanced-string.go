func balancedString(s string) int {
	n := len(s)
	k := n / 4
	cnt := make(map[byte]int)
	for i := 0; i < n; i++ {
		cnt[s[i]]++
	}

	if cnt['Q'] <= k && cnt['W'] <= k && cnt['E'] <= k && cnt['R'] <= k {
		return 0
	}

	ans := n
	left := 0
	need := make(map[byte]int)
	if cnt['Q'] > k {
		need['Q'] = cnt['Q'] - k
	}
	if cnt['W'] > k {
		need['W'] = cnt['W'] - k
	}
	if cnt['E'] > k {
		need['E'] = cnt['E'] - k
	}
	if cnt['R'] > k {
		need['R'] = cnt['R'] - k
	}

	satisfied := func() bool {
		for c, needCount := range need {
			if cnt[c] < needCount {
				return false
			}
		}
		return true
	}

	for right := 0; right < n; right++ {
		cnt[s[right]]--
		for satisfied() {
			ans = min(ans, right-left+1)
			cnt[s[left]]++
			left++
		}
	}
	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}