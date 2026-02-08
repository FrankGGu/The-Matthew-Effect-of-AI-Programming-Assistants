import "sort"

func findEvenNumbers(digits []int) []int {
	counts := make(map[int]int)
	for _, d := range digits {
		counts[d]++
	}

	var result []int
	for i := 100; i <= 999; i += 2 {
		iCounts := make(map[int]int)
		temp := i
		iCounts[temp%10]++
		temp /= 10
		iCounts[temp%10]++
		temp /= 10
		iCounts[temp%10]++

		valid := true
		for digit, count := range iCounts {
			if counts[digit] < count {
				valid = false
				break
			}
		}

		if valid {
			result = append(result, i)
		}
	}

	sort.Ints(result)
	uniqueResult := []int{}
	seen := make(map[int]bool)
	for _, num := range result {
		if !seen[num] {
			uniqueResult = append(uniqueResult, num)
			seen[num] = true
		}
	}

	return uniqueResult
}