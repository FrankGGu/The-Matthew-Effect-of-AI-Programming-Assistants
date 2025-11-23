func recommendedPairs(categories [][]string) [][]string {
    pairs := make(map[string]map[string]struct{})
    for _, category := range categories {
        for i := 0; i < len(category); i++ {
            for j := i + 1; j < len(category); j++ {
                if pairs[category[i]] == nil {
                    pairs[category[i]] = make(map[string]struct{})
                }
                pairs[category[i]][category[j]] = struct{}{}

                if pairs[category[j]] == nil {
                    pairs[category[j]] = make(map[string]struct{})
                }
                pairs[category[j]][category[i]] = struct{}{}
            }
        }
    }

    result := [][]string{}
    for key, value := range pairs {
        for k := range value {
            if key < k {
                result = append(result, []string{key, k})
            }
        }
    }
    return result
}