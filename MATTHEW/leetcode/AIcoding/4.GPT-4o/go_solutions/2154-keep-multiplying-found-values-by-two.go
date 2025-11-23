func findFinalValue(nums []int, original int) int {
    valueSet := make(map[int]struct{})
    for _, num := range nums {
        valueSet[num] = struct{}{}
    }

    for value := original; ; value *= 2 {
        if _, exists := valueSet[value]; exists {
            continue
        }
        return value
    }
}