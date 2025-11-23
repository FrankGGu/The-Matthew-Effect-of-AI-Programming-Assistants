func fillMissingData(data []string) []string {
    n := len(data)
    result := make([]string, n)

    for i := 0; i < n; i++ {
        if data[i] == "" {
            if i == 0 {
                result[i] = "0"
            } else {
                result[i] = result[i-1]
            }
        } else {
            result[i] = data[i]
        }
    }
    return result
}