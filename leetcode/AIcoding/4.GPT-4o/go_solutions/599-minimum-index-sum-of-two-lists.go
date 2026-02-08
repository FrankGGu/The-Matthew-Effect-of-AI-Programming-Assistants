func findRestaurant(list1 []string, list2 []string) []string {
    indexMap := make(map[string]int)
    for i, restaurant := range list1 {
        indexMap[restaurant] = i
    }

    minIndexSum := math.MaxInt32
    result := []string{}

    for j, restaurant := range list2 {
        if i, found := indexMap[restaurant]; found {
            indexSum := i + j
            if indexSum < minIndexSum {
                minIndexSum = indexSum
                result = []string{restaurant}
            } else if indexSum == minIndexSum {
                result = append(result, restaurant)
            }
        }
    }

    return result
}