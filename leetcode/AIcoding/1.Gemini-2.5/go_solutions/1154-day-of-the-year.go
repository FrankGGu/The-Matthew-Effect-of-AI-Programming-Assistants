import (
	"strconv"
)

func dayOfYear(date string) int {
	year, _ := strconv.Atoi(date[:4])
	month, _ := strconv.Atoi(date[5:7])
	day, _ := strconv.Atoi(date[8:])

	daysInMonth := []int{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}

	isLeap := false
	if year%4 == 0 && (year%100 != 0 || year%400 == 0) {
		isLeap = true
	}

	if isLeap {
		daysInMonth[2] = 29
	}

	totalDays := 0
	for i := 1; i < month; i++ {
		totalDays += daysInMonth[i]
	}
	totalDays += day

	return totalDays
}