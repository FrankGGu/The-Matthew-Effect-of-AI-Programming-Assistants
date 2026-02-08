func intervalIntersection(firstList [][]int, secondList [][]int) [][]int {
	result := [][]int{}
	i, j := 0, 0

	for i < len(firstList) && j < len(secondList) {
		// Current intervals from both lists
		a := firstList[i]
		b := secondList[j]

		// Calculate the start point of the intersection
		start := a[0]
		if b[0