func numberOfBeams(bank []string) int {
    prev := 0
    total := 0
    for _, row := range bank {
        count := strings.Count(row, "1")
        if count > 0 {
            total += prev * count
            prev = count
        }
    }
    return total
}