func buildArray(target []int, n int) []string {
    result := []string{}
    current := 1

    for _, num := range target {
        for current < num {
            result = append(result, "Push", "Pop")
            current++
        }
        result = append(result, "Push")
        current++
    }

    return result
}