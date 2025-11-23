func computeLPSArray(pattern string) []int {
	m := len(pattern)
	lps := make([]int, m)
	length := 0
	i := 1
	for i < m {
		if pattern[i] == pattern[length] {
			length++
			lps[i] = length
			i++
		} else {
			if length != 0 {
				length = lps[length-1]
			} else {
				lps[i] = 0
				i++
			}
		}
	}
	return lps
}

func KMPSearch(text, pattern string, lps []int) []int {
	result := []int{}
	n := len(text)
	m := len(pattern)

	if m == 0 {
		return result
	}
	if n == 0 {
		return result
	}

	i := 0
	j := 0
	for i < n {
		if pattern[j] == text[i] {
			i++
			j++
		}
		if j == m {
			result = append(result, i-j)
			j = lps[j-1]
		} else if i < n && pattern[j] != text[i] {
			if j != 0 {
				j = lps[j-1]
			} else {
				i++
			}
		}
	}
	return result
}

func findBeautifulIndices(s string, a string, b string, k int) []int {
	lpsA := computeLPSArray(a)
	indicesA := KMPSearch(s, a, lpsA)

	lpsB := computeLPSArray(b)
	indicesB := KMPSearch(s, b, lpsB)

	beautifulIndices := []int{}

	if len(indicesA) == 0 || len(indicesB) == 0 {
		return beautifulIndices
	}

	pB := 0 // Pointer for indicesB

	for _, i := range indicesA {
		// Advance pB until indicesB[pB] is at least i - k
		for pB < len(indicesB) && indicesB[pB] < i-k {
			pB++
		}

		// Check from current pB onwards for indicesB[j] <= i + k
		found := false
		currentPB := pB
		for currentPB < len(indicesB) && indicesB[currentPB] <= i+k {
			found = true
			break
		}

		if found {
			beautifulIndices = append(beautifulIndices, i)
		}
	}

	return beautifulIndices
}