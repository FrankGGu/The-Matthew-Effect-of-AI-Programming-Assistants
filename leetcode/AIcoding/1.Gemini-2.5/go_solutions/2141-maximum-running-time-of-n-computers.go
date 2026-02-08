package main

func maxRunTime(n int, batteries []int) int64 {
	var sumBatteries int64 = 0
	for _, b := range batteries {
		sumBatteries += int64(b)
	}

	var low int64 = 0
	var high int64 = sumBatteries / int64(n)
	var ans int64 = 0

	for low <= high {
		mid := low + (high-low)/2
		if canRun(n, batteries, mid) {
			ans = mid
			low = mid + 1
		} else {
			high = mid - 1
		}
	}

	return ans
}

func canRun(n int, batteries []int, targetTime int64) bool {
	if targetTime == 0 {
		return true
	}

	var totalAvailablePower int64 = 0
	for _, b := range batteries {
		totalAvailablePower += min(int64(b), targetTime)
	}

	return totalAvailablePower >= int64(n)*targetTime
}

func min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}