func minimumImpossibleOR(A []int) int {
    seen := make(map[int]struct{})
    for _, num := range A {
        seen[num] = struct{}{}
    }
    for i := 1; ; i++ {
        if _, exists := seen[i]; !exists {
            return i
        }
    }
}