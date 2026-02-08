func isSolvable(words []string, result string) bool {
	letters := make(map[rune]bool)
	leading := make(map[rune]bool)
	sum := make(map[rune]int)
	for _, word := range words {
		for i, r := range word {
			letters[r] = true
			sum[r] += pow(10, len(word)-i-1)
			if i == 0 && len(word) > 1 {
				leading[r] = true
			}
		}
	}
	for i, r := range result {
		letters[r] = true
		sum[r] -= pow(10, len(result)-i-1)
		if i == 0 && len(result) > 1 {
			leading[r] = true
		}
	}

	uniqueLetters := make([]rune, 0, len(letters))
	for r := range letters {
		uniqueLetters = append(uniqueLetters, r)
	}

	assignment := make(map[rune]int)
	used := make([]bool, 10)

	var solve func(int) bool
	solve = func(index int) bool {
		if index == len(uniqueLetters) {
			return calculateSum(sum, assignment) == 0
		}

		letter := uniqueLetters[index]
		for digit := 0; digit <= 9; digit++ {
			if used[digit] {
				continue
			}
			if digit == 0 && leading[letter] {
				continue
			}

			assignment[letter] = digit
			used[digit] = true

			if solve(index + 1) {
				return true
			}

			used[digit] = false
			delete(assignment, letter)
		}

		return false
	}

	return solve(0)
}

func calculateSum(sum map[rune]int, assignment map[rune]int) int {
	total := 0
	for letter, value := range sum {
		total += value * assignment[letter]
	}
	return total
}

func pow(base, exponent int) int {
	result := 1
	for i := 0; i < exponent; i++ {
		result *= base
	}
	return result
}