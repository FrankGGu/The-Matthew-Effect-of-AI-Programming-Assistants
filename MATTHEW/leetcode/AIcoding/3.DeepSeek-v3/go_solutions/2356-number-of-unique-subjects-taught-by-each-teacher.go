import (
    "database/sql"
)

func query(db *sql.DB) ([]SubjectCount, error) {
    query := `
        SELECT teacher_id, COUNT(DISTINCT subject_id) as cnt
        FROM Teacher
        GROUP BY teacher_id
    `
    rows, err := db.Query(query)
    if err != nil {
        return nil, err
    }
    defer rows.Close()

    var results []SubjectCount
    for rows.Next() {
        var sc SubjectCount
        err := rows.Scan(&sc.TeacherId, &sc.Cnt)
        if err != nil {
            return nil, err
        }
        results = append(results, sc)
    }
    return results, nil
}

type SubjectCount struct {
    TeacherId int
    Cnt       int
}