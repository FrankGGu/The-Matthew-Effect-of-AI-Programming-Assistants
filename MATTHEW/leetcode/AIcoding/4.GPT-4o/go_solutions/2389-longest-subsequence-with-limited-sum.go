func maxLength(arr []int, limit int) int {
    sort.Ints(arr)
    sum := 0
    count := 0
    for _, num := range arr {
        if sum + num <= limit {
            sum += num
            count++
        } else {
            break
        }
    }
    return count
}