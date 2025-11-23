package main

func melt(df []map[string]interface{}) []map[string]interface{} {
    result := make([]map[string]interface{}, 0)
    for _, row := range df {
        for key, value := range row {
            if key != "id" && key != "value" {
                newEntry := make(map[string]interface{})
                newEntry["id"] = row["id"]
                newEntry["value"] = value
                newEntry["variable"] = key
                result = append(result, newEntry)
            }
        }
    }
    return result
}