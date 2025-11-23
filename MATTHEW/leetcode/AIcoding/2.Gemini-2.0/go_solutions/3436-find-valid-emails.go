import "strings"

func validEmails(emails []string) []string {
	var res []string
	for _, email := range emails {
		parts := strings.Split(email, "@")
		if len(parts) != 2 {
			continue
		}
		local := parts[0]
		domain := parts[1]

		if !isValidDomain(domain) {
			continue
		}

		local = strings.ReplaceAll(local, ".", "")
		plusIndex := strings.Index(local, "+")
		if plusIndex != -1 {
			local = local[:plusIndex]
		}

		if isValidLocal(local) {
			res = append(res, local+"@"+domain)
		}
	}
	return res
}

func isValidDomain(domain string) bool {
	if len(domain) == 0 {
		return false
	}
	for _, char := range domain {
		if !((char >= 'a' && char <= 'z') || (char >= 'A' && char <= 'Z') || (char >= '0' && char <= '9') || char == '.' || char == '-') {
			return false
		}
	}
	return true
}

func isValidLocal(local string) bool {
	if len(local) == 0 {
		return false
	}
	for _, char := range local {
		if !((char >= 'a' && char <= 'z') || (char >= 'A' && char <= 'Z') || (char >= '0' && char <= '9')) {
			return false
		}
	}
	return true
}