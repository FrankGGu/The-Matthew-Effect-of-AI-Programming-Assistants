package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

func selectData() {
	db, err := sql.Open("mysql", "user:password@tcp(127.0.0.1:3306)/dbname")
	if err != nil {
		fmt.Println(err)
		return
	}
	defer db.Close()

	rows, err := db.Query("SELECT id, name, age FROM users WHERE age > 18 ORDER BY age DESC LIMIT 5")
	if err != nil {
		fmt.Println(err)
		return
	}
	defer rows.Close()

	for rows.Next() {
		var id int
		var name string
		var age int
		if err := rows.Scan(&id, &name, &age); err != nil {
			fmt.Println(err)
			return
		}
		fmt.Printf("%d %s %d\n", id, name, age)
	}

	if err := rows.Err(); err != nil {
		fmt.Println(err)
		return
	}
}