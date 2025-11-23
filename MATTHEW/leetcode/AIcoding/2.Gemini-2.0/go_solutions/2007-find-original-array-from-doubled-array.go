import "sort"

func findOriginalArray(changed []int) []int {
	n := len(changed)
	if n%2 != 0 {
		return []int{}
	}

	sort.Ints(changed)
	counts := make(map[int]int)
	for _, num := range changed {
		counts[num]++
	}

	original := []int{}
	for _, num := range changed {
		if counts[num] == 0 {
			continue
		}

		doubled := num * 2
		if counts[doubled] == 0 {
			return []int{}
		}

		original = append(original, num)
		counts[num]--
		counts[doubled]--
	}

	return original
}