func poorPigs(buckets int, minutesToDie int, minutesToTest int) int {
	statesPerPig := minutesToTest/minutesToDie + 1
	pigs := 0
	totalStates := 1
	for totalStates < buckets {
		totalStates *= statesPerPig
		pigs++