package main

func findTeachers(teachers [][]int) [][]int {
	teacherSubjects := make(map[int]map[int]bool)

	for _, entry := range teachers {
		teacherID := entry[0]
		subjectID := entry[1]

		if _, ok := teacherSubjects[teacherID]; !ok {
			teacherSubjects[teacherID] = make(map[int]bool)
		}
		teacherSubjects[teacherID][subjectID] = true
	}

	var result [][]int
	for teacherID, subjects := range teacherSubjects {
		result = append(result, []int{teacherID, len(subjects)})
	}

	return result
}