package main

func numIdentifiedEmails(emails []string) int {
    seen := make(map[string]bool)
    for _, email := range emails {
        local, domain := splitAtAt(email)
        local = removeDots(local)
        if idx := findPlusIndex(local); idx != -1 {
            local = local[:idx]
        }
        normalized := local + "@" + domain
        seen[normalized] = true
    }
    return len(seen)
}

func splitAtAt(s string) (string, string) {
    for i := 0; i < len(s); i++ {
        if s[i] == '@' {
            return s[:i], s[i+1:]
        }
    }
    return s, ""
}

func removeDots(s string) string {
    var result []byte
    for i := 0; i < len(s); i++ {
        if s[i] != '.' {
            result = append(result, s[i])
        }
    }
    return string(result)
}

func findPlusIndex(s string) int {
    for i := 0; i < len(s); i++ {
        if s[i] == '+' {
            return i
        }
    }
    return -1
}