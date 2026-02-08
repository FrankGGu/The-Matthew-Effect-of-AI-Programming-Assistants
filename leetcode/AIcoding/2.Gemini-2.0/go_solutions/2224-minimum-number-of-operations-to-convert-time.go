func convertTime(current string, correct string) int {
	currH := int(current[0]-'0')*10 + int(current[1]-'0')
	currM := int(current[3]-'0')*10 + int(current[4]-'0')
	corrH := int(correct[0]-'0')*10 + int(correct[1]-'0')
	corrM := int(correct[3]-'0')*10 + int(correct[4]-'0')

	diff := (corrH*60 + corrM) - (currH*60 + currM)
	if diff < 0 {
		return 0
	}

	ops := 0
	ops += diff / 60
	diff %= 60
	ops += diff / 15
	diff %= 15
	ops += diff / 5
	diff %= 5
	ops += diff

	return ops
}