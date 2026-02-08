func numUniqueEmails(emails []string) int {
    emailSet := make(map[string]struct{})

    for _, email := range emails {
        parts := strings.Split(email, "@")
        local := parts[0]
        domain := parts[1]

        if idx := strings.Index(local, "+"); idx != -1 {
            local = local[:idx]
        }

        local = strings.ReplaceAll(local, ".", "")
        validEmail := local + "@" + domain

        emailSet[validEmail] = struct{}{}
    }

    return len(emailSet)
}