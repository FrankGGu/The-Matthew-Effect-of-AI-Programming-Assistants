package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

func seasonalSalesAnalysis(db *sql.DB) ([]struct {
	Season string
	Total  int
}) {
	query := `
		SELECT 
			CASE 
				WHEN MONTH(order_date) IN (12, 1, 2) THEN 'Winter'
				WHEN MONTH(order_date) IN (3, 4, 5) THEN 'Spring'
				WHEN MONTH(order_date) IN (6, 7, 8) THEN 'Summer'
				WHEN MONTH(order_date) IN (9, 10, 11) THEN 'Autumn'
			END AS Season,
			SUM(sales) AS Total
		FROM Sales
		GROUP BY Season
	`
	rows, err := db.Query(query)
	if err != nil {
		fmt.Println(err)
		return nil
	}
	defer rows.Close()

	var results []struct {
		Season string
		Total  int
	}

	for rows.Next() {
		var result struct {
			Season string
			Total  int
		}
		if err := rows.Scan(&result.Season, &result.Total); err != nil {
			fmt.Println(err)
			return nil
		}
		results = append(results, result)
	}
	return results
}