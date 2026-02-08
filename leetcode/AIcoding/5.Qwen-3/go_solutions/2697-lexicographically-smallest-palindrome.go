package leetcode

func getSmallestString(s string) string {
	runes := []rune(s)
	left, right := 0, len(runes)-1

	for left < right {
		if runes[left] != runes[right] {
			if runes[left] < runes[right] {
				runes[right] = runes[left]
			} else {
				runes[left] = runes[right]
			}
		}
		left++
		right--
	}

	return string(runes)
}