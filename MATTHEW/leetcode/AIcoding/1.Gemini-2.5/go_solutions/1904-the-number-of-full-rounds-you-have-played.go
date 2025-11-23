func numberOfRounds(startTime string, endTime string) int {
	sParts := strings.Split(startTime, ":")
	sH, _ := strconv.Atoi(sParts[0])
	sM, _ := strconv.Atoi(s