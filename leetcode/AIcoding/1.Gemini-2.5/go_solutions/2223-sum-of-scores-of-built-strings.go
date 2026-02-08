func sumScores(s string) int64 {
	n := len(s)
	z := make([]int, n)
	z[0] = n

	var totalSum int64 = int64(n)

	L, R := 0, 0

	for i := 1; i < n; i++ {
		if i <= R {
			k := i - L
			if z[k] < R-i+1 {
				z[i] = z[k]
			} else {
				L = i
				for R+1 < n && s[R+1] == s[R+1-L] {
					R++
				}
				z[i] = R - L + 1
			}
		} else {
			L = i
			R = i - 1
			for R+1 < n && s[R+1] == s[R+1-L] {
				R++
			}
			z[i] = R - L + 1
		}
		totalSum += int64(z[i])
	}

	return totalSum
}