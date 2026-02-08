func findRestaurant(list1 []string, list2 []string) []string {
    indexMap := make(map[string]int)
    for i, s := range list1 {
        indexMap[s] = i
    }

    minSum := len(list1) + len(list2)
    var result []string

    for j, s := range list2 {
        if i, exists := indexMap[s]; exists {
            sum := i + j
            if sum < minSum {
                minSum = sum
                result = []string{s}
            } else if sum == minSum {
                result = append(result, s)
            }
        }
    }

    return result
}