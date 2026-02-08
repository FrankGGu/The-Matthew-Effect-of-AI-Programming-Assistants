func minimumOperations(nums []int) int {
    unique := make(map[int]struct{})
    for _, num := range nums {
        if num > 0 {
            unique[num] = struct{}{}
        }
    }
    return len(unique)
}