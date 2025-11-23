import "math"

func minCharacters(a string, b string) int {
	n, m := len(a), len(b)
	countA := make([]int, 26)
	countB := make([]int, 26)

	for i := 0; i < n; i++ {
		countA[a[i]-'a']++
	}
	for i := 0; i < m; i++ {
		countB[b[i]-'a']++
	}

	ans := math.MaxInt32

	for i := 0; i < 26; i++ {
		ans = min(ans, n+m-countA[i]-countB[i])
	}

	for i := 0; i < 25; i++ {
		sumA := 0
		sumB := 0
		for j := i + 1; j < 26; j++ {
			sumA += countA[j]
			sumB += countB[j]
		}
		ans = min(ans, sumA+m-sumB)

		sumA = 0
		sumB = 0
		for j := i + 1; j < 26; j++ {
			sumA += countB[j]
			sumB += countA[j]
		}
		ans = min(ans, sumA+n-sumB)
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}