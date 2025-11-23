func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func getStrongest(arr []int, k int) []int {
	//