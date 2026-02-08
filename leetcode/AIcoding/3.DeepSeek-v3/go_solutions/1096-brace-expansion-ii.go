func braceExpansionII(expression string) []string {
    stack := [][]string{}
    union := []string{}
    product := []string{""}

    for _, c := range expression {
        if c == '{' {
            stack = append(stack, union)
            stack = append(stack, product)
            union = []string{}
            product = []string{""}
        } else if c == '}' {
            prevProduct := stack[len(stack)-1]
            prevUnion := stack[len(stack)-2]
            stack = stack[:len(stack)-2]

            newUnion := make([]string, 0)
            for _, s := range union {
                newUnion = append(newUnion, s)
            }
            for _, s1 := range prevProduct {
                for _, s2 := range product {
                    newUnion = append(newUnion, s1 + s2)
                }
            }
            union = prevUnion
            product = newUnion
        } else if c == ',' {
            union = append(union, product...)
            product = []string{""}
        } else {
            newProduct := make([]string, 0)
            for _, s := range product {
                newProduct = append(newProduct, s + string(c))
            }
            product = newProduct
        }
    }
    union = append(union, product...)
    resultMap := make(map[string]bool)
    for _, s := range union {
        resultMap[s] = true
    }
    result := make([]string, 0, len(resultMap))
    for s := range resultMap {
        result = append(result, s)
    }
    sort.Strings(result)
    return result
}