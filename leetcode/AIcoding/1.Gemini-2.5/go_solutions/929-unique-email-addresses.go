package main

import (
	"strings"
)

func numUniqueEmails(emails []string) int {
	uniqueEmails := make(map[string]struct{})

	for _, email := range emails {
		parts := strings.Split(email, "@")
		localName := parts[0]
		domainName := parts[1]

		var processedLocalName strings.Builder
		for _, r := range localName {
			if r == '+' {
				break
			}
			if r != '.' {
				processedLocalName.WriteRune(r)
			}
		}

		canonicalEmail := processedLocalName.String() + "@" + domainName
		uniqueEmails[canonicalEmail] = struct{}{}
	}

	return len(uniqueEmails)
}