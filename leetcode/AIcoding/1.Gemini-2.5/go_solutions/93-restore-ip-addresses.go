func restoreIpAddresses(s string) []string {
	var result []string
	if len(s) < 4 || len(s) > 12 {
		return result
	}

	var currentIpParts []string

	var backtrack