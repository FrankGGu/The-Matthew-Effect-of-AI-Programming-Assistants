func getSmallestString(s string) string {
    n := len(s)
    chars := []byte(s)

    // Find the first character that is not 'a'
    firstNonA := -1
    for i := 0; i < n; i++ {
        if chars[i] != 'a'