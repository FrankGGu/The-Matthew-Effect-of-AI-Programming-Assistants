func findArray(pref []int) []int {
	n := len(pref)
	arr := make([]int, n)
	arr[0] = pref[0]
	for i := 1; i < n; i++ {
		arr[i] = pref[i-1] ^ pref[i]
	}
	return arr
}