func findValidEmails(emails []string) []string {
	emailRegex := regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`)

	var validEmails []string

	for _, email := range emails {
		if emailRegex.MatchString(email