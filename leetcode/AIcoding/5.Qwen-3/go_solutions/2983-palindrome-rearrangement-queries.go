package main

func canReorderToPalindrome(s string) bool {
    count := make(map[rune]int)
    for _, c := range s {
        count[c]++
    }
    oddCount := 0
    for _, v := range count {
        if v%2 != 0 {
            oddCount++
        }
    }
    return oddCount <= 1
}

func palindromeRearrangementQueries(queries []string) []bool {
    result := make([]bool, len(queries))
    for i, q := range queries {
        result[i] = canReorderToPalindrome(q)
    }
    return result
}