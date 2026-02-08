func findKthNumber(m int, n int, k int) int {
    low := 1
    high := m * n
    ans := 0

    for low <= high {
        mid := low + (high-low)/2
        count := 0
        // Calculate how many numbers in the multiplication table are less than or