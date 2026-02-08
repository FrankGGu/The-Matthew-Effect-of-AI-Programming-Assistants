type teacher struct {
	TeacherID   int
	SubjectName string
}

func countSubjects(enrollments []teacher) map[int]int {
	teacherSubjects := make(map[int]map[string]bool)
	for _, enrollment := range enrollments {
		if _, ok := teacherSubjects[enrollment.TeacherID]; !ok {
			teacherSubjects[enrollment.TeacherID] = make(map[string]bool)
		}
		teacherSubjects[enrollment.TeacherID][enrollment.SubjectName] = true
	}

	result := make(map[int]int)
	for teacherID, subjects := range teacherSubjects {
		result[teacherID] = len(subjects)
	}
	return result
}