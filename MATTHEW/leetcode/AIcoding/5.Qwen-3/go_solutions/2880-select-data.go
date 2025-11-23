package main

import "github.com/denisenkom/go-mssqldb"  
func selectData() []map[string]interface{} {  
    var result []map[string]interface{}  
    sql := "SELECT * FROM Person"  
    db, err := mssqldb.Open("server=your_server;user id=your_user;password=your_password;database=your_database")  
    if err != nil {  
        return result  
    }  
    defer db.Close()  
    rows, err := db.Query(sql)  
    if err != nil {  
        return result  
    }  
    defer rows.Close()  
    columns, _ := rows.Columns()  
    for rows.Next() {  
        row := make(map[string]interface{})  
        values := make([]interface{}, len(columns))  
        for i := range values {  
            values[i] = new(interface{})  
        }  
        if err := rows.Scan(values...); err != nil {  
            continue  
        }  
        for i, col := range columns {  
            row[col] = *(values[i].(*interface{}))  
        }  
        result = append(result, row)  
    }  
    return result  
}