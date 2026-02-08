func maximumEvenSplit(finalSum int64) []int64 {
    if finalSum%2 != 0 {
        return []int64{}
    }
    result := []int64{}
    for i := int64(2); finalSum > 0; i += 2 {
        if finalSum >= i {
            result = append(result, i)
            finalSum -= i
        } else {
            result[len(result)-1] += finalSum
            break
        }
    }
    return result
}