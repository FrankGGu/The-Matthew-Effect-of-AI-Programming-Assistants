func countBeautifulPairs(nums []int) int {
	n := len(nums)
	count := 0
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			if gcd(nums[i], nums[j]) == 1 {
				count++
			}
		}
	}
	return count
}

func countBeautifulSplits(nums []int) int {
	n := len(nums)
	count := 0
	for i := 0; i < n-1; i++ {
		left := nums[:i+1]
		right := nums[i+1:]

		distinctLeft := make(map[int]bool)
		for _, num := range left {
			distinctLeft[firstDigit(num)] = true
		}

		distinctRight := make(map[int]bool)
		for _, num := range right {
			distinctRight[lastDigit(num)] = true
		}

		if len(distinctLeft) == len(distinctRight) {
			count++
		}
	}
	return count
}

func firstDigit(num int) int {
	strNum := strconv.Itoa(num)
	firstDigit, _ := strconv.Atoi(string(strNum[0]))
	return firstDigit
}

func lastDigit(num int) int {
	return num % 10
}