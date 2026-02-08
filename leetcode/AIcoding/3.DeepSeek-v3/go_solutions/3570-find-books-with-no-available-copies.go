func findBooksWithNoAvailableCopies(books [][]int) [][]int {
    noCopies := [][]int{}
    for _, book := range books {
        if book[1] == 0 {
            noCopies = append(noCopies, book)
        }
    }
    return noCopies
}