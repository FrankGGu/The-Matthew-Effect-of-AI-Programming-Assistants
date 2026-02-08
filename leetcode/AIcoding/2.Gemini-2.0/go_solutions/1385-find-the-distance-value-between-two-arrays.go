func findTheDistanceValue(arr1 []int, arr2 []int, d int) int {
	count := 0
	for _, num1 := range arr1 {
		found := false
		for _, num2 := range arr2 {
			if abs(num1-num2) <= d {
				found = true
				break
			}
		}
		if !found {
			count++
		}
	}
	return count
}

func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}