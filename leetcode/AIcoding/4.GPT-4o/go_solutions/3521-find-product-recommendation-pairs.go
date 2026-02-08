func findProductRecommendationPairs(recommendations [][]int) [][]int {
    productMap := make(map[int]map[int]struct{})
    for _, rec := range recommendations {
        if _, ok := productMap[rec[0]]; !ok {
            productMap[rec[0]] = make(map[int]struct{})
        }
        productMap[rec[0]][rec[1]] = struct{}{}
    }

    pairs := [][]int{}
    for a, bMap := range productMap {
        for b := range bMap {
            if _, ok := productMap[b]; ok {
                for c := range productMap[b] {
                    if c != a && c != b {
                        pairs = append(pairs, []int{a, c})
                    }
                }
            }
        }
    }
    return pairs
}