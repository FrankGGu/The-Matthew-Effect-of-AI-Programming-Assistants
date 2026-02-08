import (
	"strconv"
)

func parseTime(timeStr string) int {
	hours, _ := strconv.Atoi(timeStr[:2])
	minutes, _ := strconv.Atoi(timeStr[3:])
	return hours*60 + minutes
}

func haveConflict(event1 []string, event2 []string) bool {
	s1 := parseTime(event1[0])
	e1 := parseTime(event1[1])
	s2 := parseTime(event2[0])
	e2 := parseTime(event2[1])

	return s1 <= e2 && s2 <= e1
}