func checkIfExist(arr []int) bool {
    seen := make(map[int]bool)
    for _, num := range arr {
        if seen[num*2] || (num%2 == 0 && seen[num/2]) {
            return true
        }
        seen[num] = true
    }
    return false
}