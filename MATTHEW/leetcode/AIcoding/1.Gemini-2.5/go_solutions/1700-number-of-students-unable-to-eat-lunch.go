func countStudents(students []int, sandwiches []int) int {
	stuckCount := 0
	for len(students) > 0 && len(sandwiches) > 0 {
		if students[0] == sandwiches[0] {
			// The student at the front likes the sandwich
			students = students