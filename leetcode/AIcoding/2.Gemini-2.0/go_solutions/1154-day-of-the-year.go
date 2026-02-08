func dayOfYear(date string) int {
	year := int(date[0]-'0')*1000 + int(date[1]-'0')*100 + int(date[2]-'0')*10 + int(date[3]-'0')
	month := int(date[5]-'0')*10 + int(date[6]-'0')
	day := int(date[8]-'0')*10 + int(date[9]-'0')

	days := []int{31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
	if (year%4 == 0 && year%100 != 0) || year%400 == 0 {
		days[1] = 29
	}

	ans := 0
	for i := 0; i < month-1; i++ {
		ans += days[i]
	}
	ans += day
	return ans
}