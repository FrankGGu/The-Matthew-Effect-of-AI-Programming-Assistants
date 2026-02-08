package main

func longestSpecialSubstring(s string) int {
	n := len(s)

	counts := make(map[rune]map[int]int)

	for charCode := 'a'; charCode <= 'z'; charCode++ {
		counts[charCode] = make(map[int]int)
	}

	i := 0
	for i < n {
		j := i
		for j < n && s[j] == s[i] {
			j++
		}
		runChar := rune(s[i])
		runLen := j - i

		for k := 1; k <= runLen; k++ {
			counts[runChar][k] += (runLen - k + 1)
		}
		i = j
	}

	for k := n; k >= 1; k-- {
		for charCode := 'a'; charCode <= 'z'; charCode++ {
			if counts[charCode][k] >= 3 {
				return k
			}
		}
	}

	return -1
}