func sequentialDigits(low int, high int) []int {
	result := []int{}
	for i := 1; i <= 9; i++ {
		num := i
		for num <= high {
			if num >= low && num <= high {
				result = append(result, num)
			}
			lastDigit := num % 10
			if lastDigit == 9 {
				break
			}
			num = num*10 + (lastDigit + 1)
		}
	}
	sort.Ints(result)
	return result
}

import "sort"