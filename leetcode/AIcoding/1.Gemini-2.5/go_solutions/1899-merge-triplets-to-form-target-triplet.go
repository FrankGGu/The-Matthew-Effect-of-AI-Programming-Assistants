func mergeTriplets(triplets [][]int, target []int) bool {
	foundX := false
	foundY := false
	foundZ := false

	targetX := target[0]
	targetY := target[1]
	targetZ := target[2]

	for _, t := range triplets {
		// A triplet `t