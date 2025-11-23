func lastRemaining(n int, m int) int {
	ans := 0
	// The problem is a classic Josephus problem.
	// We want to find the last remaining person's index.
	// Let f(n, m) be the index of the last remaining person (0-indexed)
	// when there