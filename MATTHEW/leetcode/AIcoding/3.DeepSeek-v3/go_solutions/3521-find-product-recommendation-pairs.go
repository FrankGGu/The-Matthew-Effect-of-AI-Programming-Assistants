func suggestedProducts(products []string, searchWord string) [][]string {
    sort.Strings(products)
    res := make([][]string, 0)
    prefix := ""
    for _, c := range searchWord {
        prefix += string(c)
        idx := sort.SearchStrings(products, prefix)
        suggestions := make([]string, 0)
        for i := idx; i < len(products) && i < idx+3; i++ {
            if strings.HasPrefix(products[i], prefix) {
                suggestions = append(suggestions, products[i])
            } else {
                break
            }
        }
        res = append(res, suggestions)
    }
    return res
}