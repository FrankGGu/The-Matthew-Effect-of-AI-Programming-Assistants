import "sort"

func checkInclusion(s1 string, s2 string) bool {
	if len(s1) > len(s2) {
		return false
	}

	s1Arr := []rune(s1)
	sort.Slice(s1Arr, func(i, j int) bool {
		return s1Arr[i] < s1Arr[j]
	})
	s1Sorted := string(s1Arr)

	for i := 0; i <= len(s2)-len(s1); i++ {
		sub := s2[i : i+len(s1)]
		subArr := []rune(sub)
		sort.Slice(subArr, func(i, j int) bool {
			return subArr[i] < subArr[j]
		})
		subSorted := string(subArr)

		if subSorted == s1Sorted {
			return true
		}
	}

	return false
}