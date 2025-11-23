package main

func minWindow(s string, t string) string {
	if len(s) == 0 || len(t) == 0 || len(s) < len(t) {
		return ""
	}

	from := 0
	to := 0
	minLen := len(s) + 1
	count := make(map[byte]int)
	required := len(t)

	for i := 0; i < len(t); i++ {
		count[t[i]]++
	}

	left := 0
	right := 0

	for right < len(s) {
		if count[s[right]] > 0 {
			required--
		}
		count[s[right]]--
		right++

		for required == 0 {
			if right-left < minLen {
				minLen = right - left
				from = left
				to = right
			}

			if count[s[left]] == 0 {
				required++
			}
			count[s[left]]++
			left++
		}
	}

	if minLen == len(s)+1 {
		return ""
	}

	return s[from:to]
}