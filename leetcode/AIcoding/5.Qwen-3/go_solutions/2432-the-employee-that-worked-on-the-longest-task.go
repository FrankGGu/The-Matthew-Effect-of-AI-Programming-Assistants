package main

func longestTask(employees []string) string {
    taskMap := make(map[string]int)
    for _, emp := range employees {
        parts := strings.Split(emp, " ")
        name := parts[0]
        task := parts[1]
        taskMap[name] = taskMap[name] + 1
    }

    var maxName string
    maxCount := 0
    for name, count := range taskMap {
        if count > maxCount {
            maxCount = count
            maxName = name
        } else if count == maxCount && name < maxName {
            maxName = name
        }
    }
    return maxName
}