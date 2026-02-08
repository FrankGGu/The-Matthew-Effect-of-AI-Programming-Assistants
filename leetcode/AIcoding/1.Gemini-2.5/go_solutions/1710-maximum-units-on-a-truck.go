import "sort"

func maximumUnits(boxTypes [][]int, truckSize int) int {
	// Sort boxTypes in descending order based on unitsPerBox_i
	sort.Slice(boxTypes, func(i, j int) bool {
		return boxTypes[i][1] > boxTypes[j][1]
	})

	totalUnits := 0
	remainingTruckSize := truckSize

	for _, boxType := range boxTypes {
		if remainingTruckSize <= 0 {
			break // Truck is full
		}

		numBoxes := boxType[0]
		unitsPerBox := boxType[1]

		// Determine how many boxes of this type can be loaded
		// It's the minimum of available boxes and remaining truck capacity
		boxesToLoad := 0
		if numBoxes < remainingTruckSize {
			boxesToLoad = numBoxes
		} else {
			boxesToLoad = remainingTruckSize
		}

		totalUnits += boxesToLoad * unitsPerBox
		remainingTruckSize -= boxesToLoad
	}

	return totalUnits
}