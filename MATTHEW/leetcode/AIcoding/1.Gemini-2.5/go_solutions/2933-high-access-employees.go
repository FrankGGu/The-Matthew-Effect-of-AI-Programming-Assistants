func findHighAccessEmployees(access_times [][]string) []string {
	employeeAccess := make(map[string][]int)

	for _, entry := range access_times {
		empName := entry[0]
		timeStr := entry[1]

		hours, _ := strconv.Atoi(timeStr[:2])
		minutes, _ := strconv.Atoi(timeStr[2:])
		totalMinutes := hours*60 + minutes

		employeeAccess[empName] = append(employeeAccess[empName], totalMinutes)
	}

	var highAccessEmployees []string

	for empName, times := range employeeAccess {
		if len(times) < 3 {
			continue
		}

		sort.Ints(times)

		foundHighAccess := false
		for i := 0; i <= len(times)-3; i++ {
			// Check if the third access (times[i+2]) is within 60 minutes of the first access (times[i])
			if times[i+2]-times[i] < 60 {
				highAccessEmployees = append(highAccessEmployees, empName)
				foundHighAccess = true
				break // Once found, no need to check further for this employee
			}
		}
	}

	// The problem statement doesn't specify if the output should be sorted,
	// but it's good practice to ensure deterministic output for testing.
	sort.Strings(highAccessEmployees) 
	return highAccessEmployees
}