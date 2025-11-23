func longestPalindrome(s string) int {
    charCounts := [128]int{}
    for i := 0; i < len(s); i++ {
        charCounts[s[i]]++
    }

    length := 0
    hasOdd := false

    for _, count := range charCounts