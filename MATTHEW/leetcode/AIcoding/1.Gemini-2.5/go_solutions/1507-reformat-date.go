func reformatDate(date string) string {
	parts := strings.Fields(date)
	dayStr := parts[0]
	monthStr := parts[1]
	yearStr := parts[2]

	monthMap := map[string]string{
		"Jan": "01", "Feb": "02", "Mar": "03", "Apr": "04",
		"May": "05", "Jun": "06", "Jul": "07", "Aug": "08",
		"Sep": "09", "Oct": "10", "Nov": "11", "Dec": "12",
	}

	dayValStr := dayStr[:len(dayStr)-2]
	dayInt, _ := strconv.Atoi(dayValStr)
	formattedDay := fmt.Sprintf("%02d", dayInt)

	formattedMonth := monthMap[monthStr]

	formattedYear := yearStr

	return fmt.Sprintf("%s-%s-%s", formattedYear, formattedMonth, formattedDay)
}