import "sort"

func findEvenNumbers(digits []int) []int {
	count := make(map[int]int)
	for _, d := range digits {
		count[d]++
	}

	result := []int{}
	for i := 100; i <= 999; i += 2 {
		tempCount := make(map[int]int)
		temp := i
		d1 := temp % 10
		temp /= 10
		d2 := temp % 10
		temp /= 10
		d3 := temp % 10

		tempCount[d1]++
		tempCount[d2]++
		tempCount[d3]++

		valid := true
		for d, c := range tempCount {
			if count[d] < c {
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