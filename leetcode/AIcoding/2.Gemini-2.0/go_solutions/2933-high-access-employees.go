import (
	"sort"
	"strconv"
)

func highAccessEmployees(access_times [][]string) []string {
	employeeMap := make(map[string][]int)
	for _, accessTime := range access_times {
		employee := accessTime[0]
		timeStr := accessTime[1]
		timeInt, _ := strconv.Atoi(timeStr)
		employeeMap[employee] = append(employeeMap[employee], timeInt)
	}

	result := []string{}
	for employee, times := range employeeMap {
		sort.Ints(times)
		for i := 2; i < len(times); i++ {
			if times[i]-times[i-2] < 60 {
				result = append(result, employee)
				break
			}
		}
	}

	return result
}