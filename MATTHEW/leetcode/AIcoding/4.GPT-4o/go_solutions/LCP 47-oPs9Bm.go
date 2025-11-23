func canPassSecurityCheck(people []int, limit int) bool {
    sum := 0
    for _, p := range people {
        sum += p
    }
    return sum <= limit
}