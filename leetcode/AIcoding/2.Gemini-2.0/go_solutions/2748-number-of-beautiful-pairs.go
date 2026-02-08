func countBeautifulPairs(nums []int) int {
	count := 0
	for i := 0; i < len(nums); i++ {
		for j := i + 1; j < len(nums); j++ {
			if gcd(firstDigit(nums[i]), lastDigit(nums[j])) == 1 {
				count++
			}
		}
	}
	return count
}

func firstDigit(n int) int {
	for n >= 10 {
		n /= 10
	}
	return n
}

func lastDigit(n int) int {
	return n % 10
}

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}