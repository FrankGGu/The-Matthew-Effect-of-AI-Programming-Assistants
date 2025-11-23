package main

func findCategoryRecommendationPairs(categories []string) []string {
    categoryMap := make(map[string][]string)
    result := []string{}

    for _, category := range categories {
        if len(category) < 2 {
            continue
        }
        prefix := category[:len(category)-1]
        suffix := category[1:]
        if other, ok := categoryMap[prefix]; ok {
            for _, o := range other {
                result = append(result, o+"-"+category)
            }
        }
        if other, ok := categoryMap[suffix]; ok {
            for _, o := range other {
                result = append(result, o+"-"+category)
            }
        }
        categoryMap[prefix] = append(categoryMap[prefix], category)
        categoryMap[suffix] = append(categoryMap[suffix], category)
    }

    return result
}