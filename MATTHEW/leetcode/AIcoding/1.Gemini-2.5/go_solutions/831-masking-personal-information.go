func maskPII(s string) string {
	// Check if it's an email address
	if strings.ContainsRune(s, '@') {
		// Email masking
		s = strings.ToLower(s)
		atIndex := strings.