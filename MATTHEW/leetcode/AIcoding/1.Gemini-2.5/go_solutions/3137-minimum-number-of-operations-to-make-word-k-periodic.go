func minimumOperations(word string, k int) int {
    n := len(word)

    // m is the total number of k-length blocks in the word
    m := n / k

    // freq map to store the count of each unique k-length substring
    freq := make(map[string]