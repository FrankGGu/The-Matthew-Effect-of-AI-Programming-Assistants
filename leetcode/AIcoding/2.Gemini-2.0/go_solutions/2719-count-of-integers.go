func count(num1 string, num2 string, min_sum int, max_sum int) int {
	mod := int(1e9 + 7)
	n1 := len(num1)
	n2 := len(num2)

	var dp func(int, int, bool, bool, string) int
	dp = func(idx int, sum int, tight1 bool, tight2 bool, num string) int {
		if sum > max_sum {
			return 0
		}
		if idx == len(num) {
			if sum >= min_sum && sum <= max_sum {
				return 1
			}
			return 0
		}

		if sum >= min_sum && sum <= max_sum {

		}

		digit1 := 0
		if tight1 {
			digit1 = int(num1[idx] - '0')
		}

		digit2 := 9
		if tight2 {
			digit2 = int(num2[idx] - '0')
		}

		ans := 0
		for digit := digit1; digit <= digit2; digit++ {
			newTight1 := tight1 && (digit == digit1)
			newTight2 := tight2 && (digit == digit2)
			newNum := num
			ans = (ans + dp(idx+1, sum+digit, newTight1, newTight2, newNum)) % mod
		}
		return ans
	}

	return dp(0, 0, true, true, num2)
}