func longestDupSubstring(s string) string {
	n := len(s)
	left, right := 1, n
	ans := ""
	for left <= right {
		mid := left + (right-left)/2
		dup := findDuplicate(s, mid)
		if dup != "" {
			ans = dup
			left = mid + 1
		} else {
			right = mid - 1
		}
	}
	return ans
}

func findDuplicate(s string, len int) string {
	n := len(s)
	if len == 0 {
		return ""
	}
	base := 29
	mod := 1000000007
	h := 0
	for i := 0; i < len; i++ {
		h = (h*base + int(s[i]-'a')) % mod
	}
	seen := make(map[int]int)
	seen[h] = 0
	pow := 1
	for i := 1; i < len; i++ {
		pow = (pow * base) % mod
	}
	for i := 1; i <= n-len; i++ {
		h = (h - int(s[i-1]-'a')*pow%mod + mod) % mod
		h = (h*base + int(s[i+len-1]-'a')) % mod
		if index, ok := seen[h]; ok {
			return s[index : index+len]
		}
		seen[h] = i
	}
	return ""
}