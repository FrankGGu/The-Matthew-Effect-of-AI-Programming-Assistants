import "fmt"

func largestPalindrome(n int) int {
	if n == 1 {
		return 9
	}

	max := 0
	pow := 1
	for i := 0; i < n; i++ {
		max = max*10 + 9
		pow *= 10
	}

	min := pow / 10

	for i := max; i >= min; i-- {
		num := i
		rev := i
		for j := num; j > 0; j /= 10 {
			rev = rev*10 + j%10
		}

		for j := max; j*j >= rev; j-- {
			if rev%j == 0 && rev/j >= min && rev/j <= max {
				return rev % 1337
			}
		}
	}

	return 0
}