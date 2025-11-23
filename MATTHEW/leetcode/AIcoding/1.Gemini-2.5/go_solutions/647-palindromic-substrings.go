func countSubstrings(s string) int {
    n := len(s)
    if n == 0 {
        return 0
    }

    count := 0

    // Helper function to expand around a center and count palindromes
    // left and right are initial indices for the center
    // For odd length palindromes, left