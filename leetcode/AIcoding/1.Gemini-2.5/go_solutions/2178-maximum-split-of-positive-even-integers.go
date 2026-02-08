func maximumEvenSplit(finalSum int64) []int64 {
	if finalSum%2 != 0 {
		return []int64{}
	}

	var result []int64
	currentEven := int64(2)

	for currentEven <= finalSum {
		// If taking currentEven leaves a sum