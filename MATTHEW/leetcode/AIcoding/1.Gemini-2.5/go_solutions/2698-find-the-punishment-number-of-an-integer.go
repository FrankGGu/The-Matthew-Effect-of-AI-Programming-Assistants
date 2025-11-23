import "strconv"

func punishmentNumber(n int) int {
	totalPunishmentSum := 0

	for i := 1; i <= n; i++ {
		square := i * i
		s := strconv.Itoa(square)

		if canPartitionSum(s, 0, 0, i) {
			totalPunishmentSum += i
		}
	}

	return totalPunishmentSum
}

func canPartitionSum(s string, index int, currentSum int, target int) bool {
	if index == len(s) {
		return currentSum == target
	}

	if currentSum > target {
		return false
	}

	for i := index; i < len(s); i++ {
		subStr := s[index : i+1]
		num, _ := strconv.Atoi(subStr)

		if canPartitionSum(s, i+1, currentSum+num, target) {
			return true
		}
	}

	return false
}