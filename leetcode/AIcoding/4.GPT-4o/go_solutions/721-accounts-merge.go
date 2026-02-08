func accountsMerge(accounts [][]string) [][]string {
    emailToName := make(map[string]string)
    graph := make(map[string][]string)

    for _, account := range accounts {
        name := account[0]
        for i := 1; i < len(account); i++ {
            email := account[i]
            emailToName[email] = name
            if i > 1 {
                graph[account[i-1]] = append(graph[account[i-1]], email)
                graph[email] = append(graph[email], account[i-1])
            }
        }
    }

    visited := make(map[string]bool)
    var result [][]string

    var dfs func(string, []string) []string
    dfs = func(email string, emails []string) []string {
        visited[email] = true
        emails = append(emails, email)
        for _, neighbor := range graph[email] {
            if !visited[neighbor] {
                emails = dfs(neighbor, emails)
            }
        }
        return emails
    }

    for email := range emailToName {
        if !visited[email] {
            emails := dfs(email, nil)
            sort.Strings(emails)
            result = append(result, append([]string{emailToName[email]}, emails...))
        }
    }

    return result
}