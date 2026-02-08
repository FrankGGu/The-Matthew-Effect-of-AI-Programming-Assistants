func getHappyStudents(students []int, candies int) int {
    happyCount := 0
    for _, student := range students {
        if candies >= student {
            happyCount++
            candies -= student
        }
    }
    return happyCount
}