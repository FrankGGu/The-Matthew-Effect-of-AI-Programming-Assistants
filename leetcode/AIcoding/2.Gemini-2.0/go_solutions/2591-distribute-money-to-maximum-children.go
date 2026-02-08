func distMoney(money int, children int) int {
	if money < children {
		return -1
	}
	money -= children
	ans := money / 7
	rem := money % 7
	if ans > children {
		return children - 1
	}
	if ans == children {
		if rem > 0 {
			return children - 1
		}
		return children
	}
	if ans < children {
		if children-ans == 1 && rem == 3 {
			return ans - 1
		}
		return ans
	}
	return -1
}