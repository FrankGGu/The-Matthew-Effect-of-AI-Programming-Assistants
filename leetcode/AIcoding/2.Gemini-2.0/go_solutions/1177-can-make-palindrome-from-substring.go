func canMakePaliQueries(s string, queries [][]int) []bool {
	n := len(s)
	prefix := make([][26]int, n+1)
	for i := 1; i <= n; i++ {
		prefix[i] = prefix[i-1]
		prefix[i][s[i-1]-'a']++
	}

	result := make([]bool, len(queries))
	for i, query := range queries {
		l, r, k := query[0], query[1], query[2]
		oddCount := 0
		for j := 0; j < 26; j++ {
			if (prefix[r+1][j] - prefix[l][j])%2 != 0 {
				oddCount++
			}
		}
		result[i] = oddCount/2 <= k
	}

	return result
}