func countSubstrings(s string, t string) int {
    n := len(s)
    m := len(t)
    count := 0

    // Iterate through all possible starting positions in s
    for i := 0; i < n; i++ {
        // Iterate through all possible starting positions in t
        for j :=