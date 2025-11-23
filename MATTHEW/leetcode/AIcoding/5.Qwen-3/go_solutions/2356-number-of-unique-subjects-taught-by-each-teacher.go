package main

import (
	"database/sql"
	"fmt"
)

func countUniqueSubjects(teacherSubjects *sql.Rows) map[string]int {
	result := make(map[string]int)
	for teacherSubjects.Next() {
		var teacherId string
		var subject string
		err := teacherSubjects.Scan(&teacherId, &subject)
		if err != nil {
			fmt.Println(err)
			continue
		}
		result[teacherId]++
	}
	return result
}