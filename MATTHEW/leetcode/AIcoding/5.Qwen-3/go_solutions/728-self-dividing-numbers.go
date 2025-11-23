package main

func selfDividingNumbers(left int, right int) []int {
	result := make([]int, 0)
	for i := left; i <= right; i++ {
		if isSelfDividing(i) {
			result = append(result, i)
		}
	}
	return result
}

func isSelfDividing(n int) bool {
	num := n
	for num > 0 {
		digit := num % 10
		if digit == 0 || n%digit != 0 {
			return false
		}
		num /= 10
	}
	return true
}