func abs(x int) int {
	if x < 0 {
		return -x
	}
	return x
}

func findClosestNumber(nums []int) int {
	closestNum := nums[0]

	for _, num := range nums {
		absNum := abs(num)
		absClosestNum := abs(closestNum)

		if absNum < absClosestNum {
			closestNum = num
		} else if absNum == absClosestNum {
			if num > closestNum {
				closestNum = num
			}
		}
	}

	return closestNum
}