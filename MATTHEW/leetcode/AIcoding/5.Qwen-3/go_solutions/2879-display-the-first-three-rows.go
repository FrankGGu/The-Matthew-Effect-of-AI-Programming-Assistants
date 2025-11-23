package main

import (
	"database/sql"
	"fmt"
)

func selectFirstThreeRows() []*sql.Row {
	rows, _ := sql.DB.Query("SELECT * FROM Students LIMIT 3")
	var result []*sql.Row
	for rows.Next() {
		var id int
		var name string
		var score float64
		rows.Scan(&id, &name, &score)
		result = append(result, &sql.Row{Values: []interface{}{id, name, score}})
	}
	return result
}