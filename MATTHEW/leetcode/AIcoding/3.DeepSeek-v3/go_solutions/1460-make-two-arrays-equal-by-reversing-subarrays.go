func canBeEqual(target []int, arr []int) bool {
    count := make(map[int]int)
    for _, num := range target {
        count[num]++
    }
    for _, num := range arr {
        if val, exists := count[num]; exists {
            if val == 0 {
                return false
            }
            count[num]--
        } else {
            return false
        }
    }
    return true
}