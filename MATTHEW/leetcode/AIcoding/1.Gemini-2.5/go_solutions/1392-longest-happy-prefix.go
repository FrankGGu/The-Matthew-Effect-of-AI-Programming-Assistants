func longestHappyPrefix(s string) string {
    n := len(s)
    if n == 0 {
        return ""
    }

    lps := make([]int, n)
    length := 0 // length of the previous longest prefix suffix

    // lps[0] is always 0, so we start from i = 1
    for i := 1; i < n; i++ {
        // If characters don't match, and we have a previous match (length > 0),
        // we try a shorter prefix suffix by looking up lps[length-1].
        for length > 0 && s[i] != s[length] {
            length = lps[length-1]
        }
        // If characters match (either initially, or after reducing length),
        // increment length and store it.
        if s[i] == s[length] {
            length++
        }
        lps[i] = length
    }

    // The length of the longest happy prefix for the entire string s is lps[n-1].
    return s[:lps[n-1]]
}