func maximumContainers(boxTypes [][]int, shipCapacity int) int {
	// Sort boxTypes by units per container in descending order.
	// boxTypes[i] = [numberOfContainers_i, unitsPerContainer_i]
	sort.Slice(boxTypes, func(i, j int) bool {
		return boxTypes[i][1] > boxTypes[j][1]
	})

	totalUnits := 0
	currentCapacity := shipCapacity

	for _, boxType := range boxTypes {
		if currentCapacity == 0 {
			break
		}

		numContainers := boxType[0]
		unitsPerContainer := boxType[1]

		// Determine how many containers of this type can be taken.
		// It's the minimum of available containers and remaining ship capacity.
		containersToTake := 0
		if numContainers <= currentCapacity {
			containersToTake = numContainers
		} else {
			containersToTake = currentCapacity
		}

		totalUnits += containersToTake * unitsPerContainer
		currentCapacity -= containersToTake
	}

	return totalUnits
}