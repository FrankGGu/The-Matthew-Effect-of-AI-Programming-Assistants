func lemonadeChange(bills []int) bool {
	count5 := 0
	count10 := 0

	for _, bill := range bills {
		if bill == 5 {
			count5++
		} else if bill == 10 {
			if count5 > 0 {
				count5--
				count10++
			} else {
				return false
			}
		} else { // bill == 20
			// Prioritize using one $10 bill and one $5 bill
			if count10 > 0 && count5 > 0 {
				count10--
				count5--
			} else if count5 >= 3 { // Otherwise, try to use three $5 bills
				count5 -= 3
			} else { // Cannot make change
				return false
			}
		}
	}

	return true
}