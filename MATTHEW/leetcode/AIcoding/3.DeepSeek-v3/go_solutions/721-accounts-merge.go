func accountsMerge(accounts [][]string) [][]string {
    emailToIndex := make(map[string]int)
    emailToName := make(map[string]string)
    index := 0

    for _, account := range accounts {
        name := account[0]
        for _, email := range account[1:] {
            if _, ok := emailToIndex[email]; !ok {
                emailToIndex[email] = index
                emailToName[email] = name
                index++
            }
        }
    }

    parent := make([]int, index)
    for i := range parent {
        parent[i] = i
    }

    var find func(int) int
    find = func(x int) int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    for _, account := range accounts {
        firstEmail := account[1]
        firstIndex := emailToIndex[firstEmail]
        for _, email := range account[2:] {
            nextIndex := emailToIndex[email]
            parent[find(nextIndex)] = find(firstIndex)
        }
    }

    indexToEmails := make(map[int][]string)
    for email, i := range emailToIndex {
        root := find(i)
        indexToEmails[root] = append(indexToEmails[root], email)
    }

    var result [][]string
    for _, emails := range indexToEmails {
        sort.Strings(emails)
        name := emailToName[emails[0]]
        merged := append([]string{name}, emails...)
        result = append(result, merged)
    }

    return result
}