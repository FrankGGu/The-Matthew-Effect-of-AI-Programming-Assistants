import (
    "sort"
    "strings"
    "unicode"
)

func reorderLogFiles(logs []string) []string {
    var letterLogs, digitLogs []string
    for _, log := range logs {
        parts := strings.SplitN(log, " ", 2)
        if unicode.IsDigit(rune(parts[1][0])) {
            digitLogs = append(digitLogs, log)
        } else {
            letterLogs = append(letterLogs, log)
        }
    }

    sort.Slice(letterLogs, func(i, j int) bool {
        s1 := strings.SplitN(letterLogs[i], " ", 2)
        s2 := strings.SplitN(letterLogs[j], " ", 2)
        if s1[1] == s2[1] {
            return s1[0] < s2[0]
        }
        return s1[1] < s2[1]
    })

    return append(letterLogs, digitLogs...)
}