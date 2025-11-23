import "container/list"

func openLock(deadends []string, target string) int {
	deadendsSet := make(map[string]bool)
	for _, d := range deadends {
		deadendsSet[d] = true
	}

	if deadendsSet["0000"] {