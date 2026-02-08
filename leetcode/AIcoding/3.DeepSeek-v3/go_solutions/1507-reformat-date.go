import (
    "strings"
)

func reformatDate(date string) string {
    monthMap := map[string]string{
        "Jan": "01",
        "Feb": "02",
        "Mar": "03",
        "Apr": "04",
        "May": "05",
        "Jun": "06",
        "Jul": "07",
        "Aug": "08",
        "Sep": "09",
        "Oct": "10",
        "Nov": "11",
        "Dec": "12",
    }

    parts := strings.Split(date, " ")
    day := parts[0]
    month := parts[1]
    year := parts[2]

    dayDigits := day[:len(day)-2]
    if len(dayDigits) == 1 {
        dayDigits = "0" + dayDigits
    }

    monthDigits := monthMap[month]

    return year + "-" + monthDigits + "-" + dayDigits
}