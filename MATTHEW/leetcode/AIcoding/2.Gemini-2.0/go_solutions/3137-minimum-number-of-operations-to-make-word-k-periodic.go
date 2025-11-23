func minOperations(word string, k int) int {
	n := len(word)
	if n%k != 0 {
		return -1
	}
	ans := 0
	for i := 0; i < k; i++ {
		counts := make(map[byte]int)
		for j := i; j < n; j += k {
			counts[word[j]]++
		}
		maxCount := 0
		for _, count := range counts {
			if count > maxCount {
				maxCount = count
			}
		}
		ans += n/k - maxCount
	}
	return ans
}