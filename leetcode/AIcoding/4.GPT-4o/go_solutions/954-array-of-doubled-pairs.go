func canReorderDoubled(A []int) bool {
    count := make(map[int]int)
    for _, num := range A {
        count[num]++
    }

    for _, num := range A {
        if count[num] == 0 {
            continue
        }
        if count[num*2] == 0 {
            return false
        }
        count[num]--
        count[num*2]--
    }

    return true
}