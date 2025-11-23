package main

func digitsDivideNumber(num int) int {
	count := 0
	n := num
	for n > 0 {
		digit := n % 10
		if num%digit == 0 {
			count++
		}
		n /= 10
	}
	return count
}