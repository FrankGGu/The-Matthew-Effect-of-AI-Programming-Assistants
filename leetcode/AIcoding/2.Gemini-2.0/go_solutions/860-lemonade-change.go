func lemonadeChange(bills []int) bool {
	five := 0
	ten := 0
	for _, bill := range bills {
		if bill == 5 {
			five++
		} else if bill == 10 {
			five--
			ten++
		} else {
			if ten > 0 {
				ten--
				five--
			} else {
				five -= 3
			}
		}
		if five < 0 {
			return false
		}
		if ten < 0 {
			return false
		}
	}
	return true
}