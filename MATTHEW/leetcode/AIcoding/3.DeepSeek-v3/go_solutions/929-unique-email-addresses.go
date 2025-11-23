func numUniqueEmails(emails []string) int {
    unique := make(map[string]bool)
    for _, email := range emails {
        parts := strings.Split(email, "@")
        local := parts[0]
        domain := parts[1]
        local = strings.Split(local, "+")[0]
        local = strings.ReplaceAll(local, ".", "")
        unique[local+"@"+domain] = true
    }
    return len(unique)
}