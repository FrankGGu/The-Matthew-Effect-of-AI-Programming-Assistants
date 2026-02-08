package main

import (
	"database/sql"
	"fmt"
)

func accountSummaryII() []*sql.NullString {
	query := "SELECT u.name, SUM(t.amount) AS balance FROM Users u JOIN Transactions t ON u.account = t.account GROUP BY u.account HAVING SUM(t.amount) > 0;"
	rows, _ := sql.Query(query)
	defer rows.Close()

	var result []*sql.NullString
	for rows.Next() {
		var name string
		var balance sql.NullString
		rows.Scan(&name, &balance)
		result = append(result, &balance)
	}
	return result
}