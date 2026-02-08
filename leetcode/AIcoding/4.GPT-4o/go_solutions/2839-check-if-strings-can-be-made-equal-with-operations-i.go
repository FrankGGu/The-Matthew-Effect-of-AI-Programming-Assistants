func canBeEqual(target []int, arr []int) bool {
    if len(target) != len(arr) {
        return false
    }
    counter := make(map[int]int)
    for _, num := range target {
        counter[num]++
    }
    for _, num := range arr {
        counter[num]--
        if counter[num] < 0 {
            return false
        }
    }
    return true
}