func maximumEvenSplit(finalSum int64) []int64 {
	if finalSum%2 != 0 {
		return []int64{}
	}
	result := []int64{}
	cur := int64(2)
	for finalSum > 0 {
		if finalSum-cur > cur {
			result = append(result, cur)
			finalSum -= cur
			cur += 2
		} else {
			result = append(result, finalSum)
			finalSum = 0
		}
	}
	return result
}