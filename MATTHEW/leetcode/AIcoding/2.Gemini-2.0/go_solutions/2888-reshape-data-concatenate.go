func concatenate(arr [][]int) []int {
	res := []int{}
	for _, row := range arr {
		res = append(res, row...)
	}
	return res
}