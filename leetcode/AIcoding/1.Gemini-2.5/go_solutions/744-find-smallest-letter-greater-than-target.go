func nextGreatestLetter(letters []byte, target byte) byte {
	n := len(letters)
	left, right := 0, n-1
	ans := letters[0] // Default to the first character for wrap-around case

	for left <= right {
		mid := left + (right-left)/2
		if letters[mid] > target {
			ans = letters[mid]
			right = mid - 1
		} else {
			left = mid + 1
		}
	}
	return ans
}