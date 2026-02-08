func removeMethods(project []string) []string {
    methodMap := make(map[string]struct{})

    for _, method := range project {
        parts := strings.Split(method, " ")
        if len(parts) > 1 {
            methodMap[parts[1]] = struct{}{}
        }
    }

    result := []string{}
    for _, method := range project {
        parts := strings.Split(method, " ")
        if len(parts) == 1 || _, exists := methodMap[parts[0]]; !exists {
            result = append(result, method)
        }
    }

    return result
}