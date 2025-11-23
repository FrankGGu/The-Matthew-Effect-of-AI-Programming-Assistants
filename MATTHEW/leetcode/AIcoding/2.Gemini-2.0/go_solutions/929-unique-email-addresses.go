import "strings"

func numUniqueEmails(emails []string) int {
	uniqueEmails := make(map[string]bool)
	for _, email := range emails {
		parts := strings.Split(email, "@")
		localName := parts[0]
		domainName := parts[1]

		plusIndex := strings.Index(localName, "+")
		if plusIndex != -1 {
			localName = localName[:plusIndex]
		}

		localName = strings.ReplaceAll(localName, ".", "")

		uniqueEmails[localName+"@"+domainName] = true
	}

	return len(uniqueEmails)
}