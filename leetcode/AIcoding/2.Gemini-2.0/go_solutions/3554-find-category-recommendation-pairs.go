import "sort"

func findHighAccessEmployees(accessTimes [][]string) []string {
	employeeTimes := make(map[string][]int)
	for _, accessTime := range accessTimes {
		employee := accessTime[0]
		time := accessTime[1]
		hour := int(time[0]-'0')*10 + int(time[1]-'0')
		minute := int(time[2]-'0')*10 + int(time[3]-'0')
		totalMinutes := hour*60 + minute
		employeeTimes[employee] = append(employeeTimes[employee], totalMinutes)
	}

	result := []string{}
	for employee, times := range employeeTimes {
		sort.Ints(times)
		for i := 0; i < len(times)-2; i++ {
			if times[i+2]-times[i] < 60 {
				result = append(result, employee)
				break
			}
		}
	}

	return result
}