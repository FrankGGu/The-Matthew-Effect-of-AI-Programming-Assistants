package main

func findBooksNoAvailableCopies(books []string, copies map[string]int) []string {
    result := []string{}
    for _, book := range books {
        if copies[book] == 0 {
            result = append(result, book)
        }
    }
    return result
}