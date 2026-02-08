func minimumOperations(nums []int) int {
    unique := make(map[int]bool)
    for _, num := range nums {
        if num > 0 {
            unique[num] = true
        }
    }
    return len(unique)
}