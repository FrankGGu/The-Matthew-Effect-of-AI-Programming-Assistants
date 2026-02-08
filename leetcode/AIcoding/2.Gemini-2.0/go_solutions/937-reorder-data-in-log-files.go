import (
	"sort"
	"strconv"
	"strings"
)

func reorderLogFiles(logs []string) []string {
	letterLogs := []string{}
	digitLogs := []string{}

	for _, log := range logs {
		parts := strings.SplitN(log, " ", 2)
		if _, err := strconv.Atoi(parts[1][:1]); err == nil {
			digitLogs = append(digitLogs, log)
		} else {
			letterLogs = append(letterLogs, log)
		}
	}

	sort.Slice(letterLogs, func(i, j int) bool {
		partsI := strings.SplitN(letterLogs[i], " ", 2)
		partsJ := strings.SplitN(letterLogs[j], " ", 2)
		if partsI[1] == partsJ[1] {
			return partsI[0] < partsJ[0]
		}
		return partsI[1] < partsJ[1]
	})

	return append(letterLogs, digitLogs...)
}