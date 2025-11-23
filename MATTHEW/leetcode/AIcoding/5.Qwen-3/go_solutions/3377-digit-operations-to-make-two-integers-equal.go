package main

func equalizeDigits(a int, b int) int {
	for a != b {
		if a > b {
			a -= a % 10
		} else {
			b -= b % 10
		}
	}
	return a
}