import (
	"strconv"
	"strings"
)

func dayOfYear(date string) int {
	parts := strings.Split(date, "-")
	year, _ := strconv.Atoi(parts[0])
	month, _ := strconv.Atoi(parts[1])
	day, _ := strconv.Atoi(parts[2])

	daysInMonth := []int{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
	if (year%4 == 0 && year%100 != 0) || year%400 == 0 {
		daysInMonth[2] = 29
	}

	dayOfYear := 0
	for i := 1; i < month; i++ {
		dayOfYear += daysInMonth[i]
	}
	dayOfYear += day

	return dayOfYear
}

func toBinary(n int) string {
	binary := ""
	for n > 0 {
		binary = strconv.Itoa(n%2) + binary
		n /= 2
	}
	return binary
}

func solve() string {
	date := "2019-01-09"
	day := dayOfYear(date)
	binary := toBinary(day)
	return binary
}