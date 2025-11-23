package main

func accountsMerge(accounts [][]string) [][]string {
    parent := make(map[string]string)
    nameMap := make(map[string]string)

    var find func(string) string
    find = func(x string) string {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    var union func(string, string)
    union = func(x, y string) {
        rootX := find(x)
        rootY := find(y)
        if rootX != rootY {
            parent[rootX] = rootY
        }
    }

    for _, account := range accounts {
        name := account[0]
        email := account[1]
        nameMap[email] = name
        if _, exists := parent[email]; !exists {
            parent[email] = email
        }
        for i := 2; i < len(account); i++ {
            otherEmail := account[i]
            if _, exists := parent[otherEmail]; !exists {
                parent[otherEmail] = otherEmail
            }
            union(email, otherEmail)
        }
    }

    groups := make(map[string][]string)
    for email := range parent {
        root := find(email)
        groups[root] = append(groups[root], email)
    }

    result := [][]string{}
    for _, emails := range groups {
        sort.Strings(emails)
        name := nameMap[emails[0]]
        result = append(result, append([]string{name}, emails...))
    }

    return result
}