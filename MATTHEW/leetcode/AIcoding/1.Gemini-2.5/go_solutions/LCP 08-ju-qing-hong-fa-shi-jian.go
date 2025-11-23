package main

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func getTriggerTime(plots [][]int, attribute [][]int) []int {
	numPlots := len(plots)
	numDays := len(attribute)

	cumulativeMaxAttribute := make([][]int, numDays)
	cumulativeMaxAttribute[0] = make([]int, 3)
	cumulativeMaxAttribute[0][0] = attribute[0][0]
	cumulativeMaxAttribute[0][1] = attribute[0][1]
	cumulativeMaxAttribute[0][2] = attribute[0][2]

	for j := 1; j < numDays; j++ {
		cumulativeMaxAttribute[j] = make([]int, 3)
		cumulativeMaxAttribute[j][0] = max(cumulativeMaxAttribute[j-1][0], attribute[j][0])
		cumulativeMaxAttribute[j][1] = max(cumulativeMaxAttribute[j-1][1], attribute[j][1])
		cumulativeMaxAttribute[j][2] = max(cumulativeMaxAttribute[j-1][2], attribute[j][2])
	}

	ans := make([]int, numPlots)
	for i := 0; i < numPlots; i++ {
		requiredA := plots[i][0]
		requiredB := plots[i][1]
		requiredC := plots[i][2]

		low := 0
		high := numDays - 1
		triggerDay := -1

		for low <= high {
			mid := low + (high-low)/2

			if cumulativeMaxAttribute[mid][0] >= requiredA &&
				cumulativeMaxAttribute[mid][1] >= requiredB &&
				cumulativeMaxAttribute[mid][2] >= requiredC {

				triggerDay = mid
				high = mid - 1
			} else {
				low = mid + 1
			}
		}
		ans[i] = triggerDay
	}

	return ans
}