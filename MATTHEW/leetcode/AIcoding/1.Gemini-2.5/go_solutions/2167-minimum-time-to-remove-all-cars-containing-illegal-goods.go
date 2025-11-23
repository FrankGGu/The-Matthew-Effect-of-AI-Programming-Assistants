func minimumTime(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }

    // dpLeft[i] stores the minimum cost to remove all '1's in the prefix s[0...i]
    // where these removals are done from the left side.