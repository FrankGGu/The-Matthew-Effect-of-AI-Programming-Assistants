var result []string
var sGlobal string

func restoreIpAddresses(s string) []string {
	result = []string{} // Reset for each test case
	sGlobal = s

	// An IP address must have 4 parts. The shortest possible is