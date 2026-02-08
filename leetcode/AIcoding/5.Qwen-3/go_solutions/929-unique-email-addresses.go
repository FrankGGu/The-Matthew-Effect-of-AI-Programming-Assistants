package main

func numUniqueEmails(emails []string) int {
    unique := make(map[string]bool)
    for _, email := range emails {
        local := ""
        i := 0
        for i < len(email) && email[i] != '@' {
            if email[i] == '.' {
                i++
                continue
            }
            if email[i] == '+' {
                break
            }
            local += string(email[i])
            i++
        }
        domain := email[i:]
        unique[local+domain] = true
    }
    return len(unique)
}