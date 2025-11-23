package main

func largestPalindrome(n int) int {
	if n == 1 {
		return 9
	}
	max := 1
	for i := 0; i < n; i++ {
		max *= 10
	}
	min := max / 10
	for i := max - 1; i >= min; i-- {
		num := i
		temp := i
		for temp > 0 {
			num = num*10 + temp%10
			temp /= 10
		}
		for j := max - 1; j >= min; j-- {
			if num/j > max-1 {
				break
			}
			if num%j == 0 {
				return num % 1000000007
			}
		}
	}
	return 9
}