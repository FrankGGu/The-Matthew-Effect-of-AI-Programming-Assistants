import (
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
)

func accountSummaryII(db *sql.DB) []struct {
    Name   string
    Balance int
} {
    query := `
        SELECT u.name, SUM(t.amount) AS balance
        FROM Users u
        JOIN Transactions t ON u.account = t.account
        GROUP BY u.account
        HAVING balance > 10000
    `

    rows, err := db.Query(query)
    if err != nil {
        panic(err)
    }
    defer rows.Close()

    var result []struct {
        Name   string
        Balance int
    }

    for rows.Next() {
        var name string
        var balance int
        if err := rows.Scan(&name, &balance); err != nil {
            panic(err)
        }
        result = append(result, struct {
            Name   string
            Balance int
        }{name, balance})
    }

    if err := rows.Err(); err != nil {
        panic(err)
    }

    return result
}