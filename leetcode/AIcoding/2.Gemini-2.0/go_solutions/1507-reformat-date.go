import (
	"strconv"
	"strings"
)

func reformatDate(date string) string {
	months := map[string]string{
		"Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04", "May": "05", "Jun": "06",
		"Jul": "07", "Aug": "08", "Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12",
	}

	parts := strings.Split(date, " ")
	dayStr := parts[0]
	month := parts[1]
	year := parts[2]

	day := ""
	for i := 0; i < len(dayStr); i++ {
		if dayStr[i] >= '0' && dayStr[i] <= '9' {
			day += string(dayStr[i])
		}
	}

	dayInt, _ := strconv.Atoi(day)
	dayFormatted := ""
	if dayInt < 10 {
		dayFormatted = "0" + strconv.Itoa(dayInt)
	} else {
		dayFormatted = strconv.Itoa(dayInt)
	}

	return year + "-" + months[month] + "-" + dayFormatted
}