func findBooks(books [][]int) []int {
    result := []int{}
    for i, book := range books {
        if book[1] == 0 {
            result = append(result, book[0])
        }
    }
    return result
}