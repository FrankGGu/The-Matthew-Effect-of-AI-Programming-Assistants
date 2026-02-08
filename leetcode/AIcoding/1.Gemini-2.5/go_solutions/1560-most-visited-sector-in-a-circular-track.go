func mostVisited(n int, rounds []int) []int {
    // Create a frequency map or array to store visit counts for each sector.
    // Sectors are 1-indexed, so an array of size n+1 is convenient.
    counts := make([]int, n+1)

    // Iterate through the rounds to count visits