func countDistinctIntegers(nums []int) int {
	distinctNumbers := make(map[int]bool)

	reverseInt := func(n int) int {
		reversedNum := 0
		for n > 0 {
			digit := n % 10
			reversedNum = reversedNum*10 + digit
			n /= 10
		}
		return reversedNum
	}

	for _, num := range nums {
		distinctNumbers[num] = true
		reversed := reverseInt(num)
		distinctNumbers[reversed] = true
	}

	return len(distinctNumbers)
}