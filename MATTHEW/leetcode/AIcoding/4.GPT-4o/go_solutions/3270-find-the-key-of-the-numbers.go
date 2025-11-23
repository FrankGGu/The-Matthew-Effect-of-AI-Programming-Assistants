func findTheKey(numbers []int, key int) int {
    for i, num := range numbers {
        if num == key {
            return i
        }
    }
    return -1
}