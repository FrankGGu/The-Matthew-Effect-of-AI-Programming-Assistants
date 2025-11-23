func maxHeight(cuboids [][]int) int {
	for i := range cuboids {
		sort.Ints(cuboids[i])
	}

	sort.Slice(cuboids, func(i, j int) bool {
		if cuboids[i][0] != cuboids[