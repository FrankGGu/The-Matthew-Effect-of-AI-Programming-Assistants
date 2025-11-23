func numberOfSubstrings(s string) int {
    n := len(s)
    counts := [3]int{} // counts[0] for 'a', counts[1] for 'b', counts[2] for 'c'
    ans := 0
    left := 0

    for right := 0; right < n; right++ {
        counts[s[right]-'a']++

        // While the current window s[left...right] contains all three characters
        for counts[0] > 0 && counts[1] > 0 && counts[2] > 0 {
            // If s[left...right] is a valid substring, then any substring
            // starting at 'left' and ending at 'right', 'right+1', ..., 'n-1'
            // will also be valid. There are (n - right) such substrings.
            ans += (n - right)

            // Shrink the window from the left by moving 'left' pointer
            counts[s[left]-'a']--
            left++
        }
    }
    return ans
}