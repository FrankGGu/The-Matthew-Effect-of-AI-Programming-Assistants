func convertDate(date string) string {
    months := map[string]string{
        "Jan": "0001",
        "Feb": "0010",
        "Mar": "0011",
        "Apr": "0100",
        "May": "0101",
        "Jun": "0110",
        "Jul": "0111",
        "Aug": "1000",
        "Sep": "1001",
        "Oct": "1010",
        "Nov": "1011",
        "Dec": "1100",
    }
    parts := strings.Split(date, " ")
    day := fmt.Sprintf("%05b", atoi(parts[1]))
    month := months[parts[0]]
    year := fmt.Sprintf("%07b", atoi(parts[2]))

    return year + month + day
}

func atoi(s string) int {
    res, _ := strconv.Atoi(s)
    return res
}