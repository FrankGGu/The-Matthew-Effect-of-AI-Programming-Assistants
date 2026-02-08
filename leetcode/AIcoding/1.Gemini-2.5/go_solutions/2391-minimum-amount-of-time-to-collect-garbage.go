func garbageCollection(garbage []string, travel []int) int {
	totalTime := 0

	// Calculate total collection time for all garbage
	for _, houseGarbage := range garbage {
		totalTime += len(houseGarbage) // 1 minute per unit