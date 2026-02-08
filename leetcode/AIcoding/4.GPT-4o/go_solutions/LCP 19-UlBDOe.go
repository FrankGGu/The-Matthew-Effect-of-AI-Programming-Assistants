func numUniqueEmails(emails []string) int {
    uniqueEmails := make(map[string]struct{})

    for _, email := range emails {
        parts := strings.Split(email, "@")
        local := strings.ReplaceAll(parts[0], ".", "")
        plusIndex := strings.Index(local, "+")
        if plusIndex != -1 {
            local = local[:plusIndex]
        }
        uniqueEmail := local + "@" + parts[1]
        uniqueEmails[uniqueEmail] = struct{}{}
    }

    return len(uniqueEmails)
}