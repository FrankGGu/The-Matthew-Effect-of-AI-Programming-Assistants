func mergeTriplets(triplets [][]int, target []int) bool {
	good := [3]bool{}
	for _, t := range triplets {
		if t[0] <= target[0] && t[1] <= target[1] && t[2] <= target[2] {
			if t[0] == target[0] {
				good[0] = true
			}
			if t[1] == target[1] {
				good[1] = true
			}
			if t[2] == target[2] {
				good[2] = true
			}
		}
	}
	return good[0] && good[1] && good[2]
}