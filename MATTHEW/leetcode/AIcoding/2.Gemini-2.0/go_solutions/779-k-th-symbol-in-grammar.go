func kthGrammar(n int, k int) int {
	if n == 1 {
		return 0
	}
	half := 1 << (n - 2)
	if k <= half {
		return kthGrammar(n-1, k)
	} else {
		return 1 - kthGrammar(n-1, k-half)
	}
}