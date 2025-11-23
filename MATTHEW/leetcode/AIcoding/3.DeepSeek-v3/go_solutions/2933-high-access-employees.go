import (
	"sort"
	"strconv"
)

func findHighAccessEmployees(access_times [][]string) []string {
	employeeAccess := make(map[string][]int)
	for _, access := range access_times {
		name := access[0]
		timeStr := access[1]
		time, _ := strconv.Atoi(timeStr)
		employeeAccess[name] = append(employeeAccess[name], time)
	}

	var result []string
	for name, times := range employeeAccess {
		sort.Ints(times)
		for i := 0; i < len(times)-2; i++ {
			if times[i+2]-times[i] < 100 {
				result = append(result, name)
				break
			}
		}
	}
	return result
}