package main

import (
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
)

func displayFirstThreeRows(db *sql.DB) (*sql.Rows, error) {
    query := "SELECT * FROM your_table LIMIT 3"
    return db.Query(query)
}