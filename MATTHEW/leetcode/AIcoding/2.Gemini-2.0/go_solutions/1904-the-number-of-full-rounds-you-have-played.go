func numberOfRounds(startTime string, finishTime string) int {
	startH := int((startTime[0]-'0')*10 + (startTime[1] - '0'))
	startM := int((startTime[3]-'0')*10 + (startTime[4] - '0'))
	finishH := int((finishTime[0]-'0')*10 + (finishTime[1] - '0'))
	finishM := int((finishTime[3]-'0')*10 + (finishTime[4] - '0'))

	start := startH*60 + startM
	finish := finishH*60 + finishM

	if finish < start {
		finish += 24 * 60
	}

	rounds := 0
	start = (start + 14) / 15 * 15
	if start > finish {
		return 0
	}
	rounds = (finish - start) / 15

	return rounds
}