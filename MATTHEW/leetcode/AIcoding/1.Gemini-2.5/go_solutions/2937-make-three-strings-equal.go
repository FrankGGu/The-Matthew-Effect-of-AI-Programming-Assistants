func minimumDeletions(s1 string, s2 string, s3 string) int {
	len1 := len(s1)
	len2 := len(s2)
	len3 := len(s3)

	// Determine the maximum possible length for a common prefix