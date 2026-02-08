func reorderLogFiles(logs []string) []string {
    var letterLogs, digitLogs []string

    for _, log := range logs {
        if log[len(log)-1] >= '0' && log[len(log)-1] <= '9' {
            digitLogs = append(digitLogs, log)
        } else {
            letterLogs = append(letterLogs, log)
        }
    }

    sort.Slice(letterLogs, func(i, j int) bool {
        splitI := strings.Split(letterLogs[i], " ", 2)
        splitJ := strings.Split(letterLogs[j], " ", 2)
        if splitI[1] == splitJ[1] {
            return splitI[0] < splitJ[0]
        }
        return splitI[1] < splitJ[1]
    })

    return append(letterLogs, digitLogs...)
}