func sumDigits(num int64) int {
	sum := 0
	for num > 0 {
		sum += int(num % 10)
		num /= 10
	}
	return sum
}

func minimumBeautifulNumber(n int64, target int) int64 {
	if sumDigits(n) <= target {
		return 0
	}

	ans := int64(0)
	currentN := n
	powerOf10 := int64(1)

	for sumDigits(currentN) > target {
		remainder := currentN % (powerOf10 * 10)

		if remainder == 0 {
			powerOf10 *= 10
			continue
		}

		toAdd := (powerOf10 * 10) - remainder
		ans += toAdd
		currentN += toAdd

		powerOf10 *= 10
	}

	return ans
}