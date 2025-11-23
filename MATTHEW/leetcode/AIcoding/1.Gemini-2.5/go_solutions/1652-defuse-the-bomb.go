package main

func decrypt(code []int, k int) []int {
	n := len(code)
	result := make([]int, n)

	if k == 0 {
		return result
	}

	if k > 0 {
		for i := 0; i < n; i++ {
			currentSum := 0
			for j := 1; j <= k; j++ {
				index := (i + j) % n
				currentSum += code[index]
			}
			result[i] = currentSum
		}
	} else { // k < 0
		absK := -k
		for i := 0; i < n; i++ {
			currentSum := 0
			for j := 1; j <= absK; j++ {
				index := (i - j + n) % n
				currentSum += code[index]
			}
			result[i] = currentSum
		}
	}

	return result
}