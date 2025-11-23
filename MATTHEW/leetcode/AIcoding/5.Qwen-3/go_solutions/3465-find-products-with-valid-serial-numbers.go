package main

func findProducts(products []string, serials []string) []string {
    serialSet := make(map[string]bool)
    for _, s := range serials {
        serialSet[s] = true
    }

    result := []string{}
    for _, p := range products {
        if _, exists := serialSet[p]; exists {
            result = append(result, p)
        }
    }

    return result
}