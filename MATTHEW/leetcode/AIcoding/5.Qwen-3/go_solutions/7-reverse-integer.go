package main

func reverseInteger(x int) int {
	var reversed int
	for x != 0 {
		digit := x % 10
		x /= 10
		reversed = reversed*10 + digit
	}
	return reversed
}