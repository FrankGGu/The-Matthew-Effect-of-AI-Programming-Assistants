package main

type Student struct {
	StudentID int
	Score1    int
	Score2    int
}

func findStudentsWhoImproved(students []Student) []int {
	improvedStudents := []int{}
	for _, student := range students {
		if student.Score2 > student.Score1 {
			improvedStudents = append(improvedStudents, student.StudentID)
		}
	}
	return improvedStudents
}