func minMovesToMakePalindrome(s string) int {
	n := len(s)
	arr := []rune(s)
	ans := 0
	for i := 0; i < n/2; i++ {
		j := n - 1 - i
		for arr[i] != arr[j] {
			j--
		}
		if i == j {
			ans += solve(arr, i)
		} else {
			ans += solve(arr, j)
			arr = append(arr[:j], arr[j+1:]...)
			n--
		}
	}
	return ans
}

func solve(arr []rune, idx int) int {
	ans := 0
	for i := idx; i > 0; i-- {
		arr[i], arr[i-1] = arr[i-1], arr[i]
		ans++
	}
	return ans
}