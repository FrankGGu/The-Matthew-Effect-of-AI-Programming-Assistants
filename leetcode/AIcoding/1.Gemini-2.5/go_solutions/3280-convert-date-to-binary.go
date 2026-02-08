func convertDateToBinary(dateString string) string {
	t, err := time.ParseInLocation("2006-01-02", dateString, time.UTC)
	if err != nil {
		return ""
	}

	timestamp := t.Unix()

	binaryString := strconv.FormatInt(timestamp, 2)

	return binaryString
}