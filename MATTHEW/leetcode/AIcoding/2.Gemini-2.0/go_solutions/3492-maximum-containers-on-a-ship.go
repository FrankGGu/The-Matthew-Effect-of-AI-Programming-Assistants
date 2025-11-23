import "sort"

func maximumUnits(boxTypes [][]int, truckSize int) int {
	sort.Slice(boxTypes, func(i, j int) bool {
		return boxTypes[i][1] > boxTypes[j][1]
	})

	totalUnits := 0
	for _, boxType := range boxTypes {
		numBoxes := boxType[0]
		unitsPerBox := boxType[1]

		if truckSize >= numBoxes {
			totalUnits += numBoxes * unitsPerBox
			truckSize -= numBoxes
		} else {
			totalUnits += truckSize * unitsPerBox
			truckSize = 0
			break
		}
	}

	return totalUnits
}