func reorderLogFiles(logs []string) []string {
	var letterLogs []string
	var digitLogs []string

	for _, log := range logs {
		spaceIndex := strings.IndexByte(log, ' ')
		// According to problem constraints, logs always