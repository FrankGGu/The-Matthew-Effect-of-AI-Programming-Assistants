func minimumWhiteTiles(floor string, numCarpets int, carpetLen int) int {
    n := len(floor)

    // prefixWhiteTiles[k] stores the number of white tiles ('1's) in floor[0...k-1]
    prefixWhiteTiles := make([]int, n+1)