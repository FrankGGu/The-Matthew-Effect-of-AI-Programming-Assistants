func countTestedDevices(batteryPercentages []int) int {
	count := 0
	for i := 0; i < len(batteryPercentages); i++ {
		if batteryPercentages[i] > 0 {
			count++
			for j := i + 1; j < len(batteryPercentages); j++ {
				batteryPercentages[j] = max(0, batteryPercentages[j]-1)
			}
		}
	}
	return count
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}