func checkIfExist(arr []int) bool {
    numMap := make(map[int]bool)
    for _, num := range arr {
        if numMap[num*2] || (num%2 == 0 && numMap[num/2]) {
            return true
        }
        numMap[num] = true
    }
    return false
}