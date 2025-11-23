func findProducts(serials []string) []string {
    serialMap := make(map[string]bool)
    result := []string{}

    for _, serial := range serials {
        if _, exists := serialMap[serial]; !exists {
            serialMap[serial] = true
            result = append(result, serial)
        }
    }

    return result
}