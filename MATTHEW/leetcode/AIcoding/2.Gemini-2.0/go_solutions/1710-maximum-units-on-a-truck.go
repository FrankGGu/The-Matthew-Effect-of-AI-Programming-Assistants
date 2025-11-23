import "sort"

func maximumUnits(boxTypes [][]int, truckSize int) int {
	sort.Slice(boxTypes, func(i, j int) bool {
		return boxTypes[i][1] > boxTypes[j][1]
	})

	totalUnits := 0
	for _, box := range boxTypes {
		if truckSize >= box[0] {
			totalUnits += box[0] * box[1]
			truckSize -= box[0]
		} else {
			totalUnits += truckSize * box[1]
			break
		}
	}

	return totalUnits
}