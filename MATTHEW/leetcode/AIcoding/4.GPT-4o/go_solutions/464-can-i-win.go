func canIWin(maxChoosableInteger int, desiredTotal int) bool {
	if desiredTotal <= 0 {
		return true
	}
	if (maxChoosableInteger*(maxChoosableInteger+1))/2 < desiredTotal {
		return false
	}
	mem := make(map[int]bool)
	return canWin(0, maxChoosableInteger, desiredTotal, mem)
}

func canWin(state int, maxChoosableInteger int, desiredTotal int, mem map[int]bool) bool {
	if v, ok := mem[state]; ok {
		return v
	}
	for i := 1; i <= maxChoosableInteger; i++ {
		if (state&(1<<(i-1))) == 0 {
			if desiredTotal <= i || !canWin(state|(1<<(i-1)), maxChoosableInteger, desiredTotal-i, mem) {
				mem[state] = true
				return true
			}
		}
	}
	mem[state] = false
	return false
}