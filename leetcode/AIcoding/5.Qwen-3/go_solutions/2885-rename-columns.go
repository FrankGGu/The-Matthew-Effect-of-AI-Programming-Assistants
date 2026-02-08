package main

func renameColumns(employees []string) []string {
    if len(employees) == 0 {
        return employees
    }
    result := make([]string, len(employees))
    for i, s := range employees {
        parts := strings.Split(s, ",")
        if len(parts) >= 3 {
            result[i] = parts[0] + "," + parts[1] + "," + parts[2]
        } else {
            result[i] = s
        }
    }
    return result
}