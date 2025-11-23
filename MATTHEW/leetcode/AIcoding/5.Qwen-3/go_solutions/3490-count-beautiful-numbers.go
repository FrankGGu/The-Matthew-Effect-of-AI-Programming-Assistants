package main

func countBeautifulNumbers(n int) int {
    if n < 10 {
        return 0
    }
    count := 0
    for i := 10; i <= n; i++ {
        s := strconv.Itoa(i)
        freq := make(map[rune]int)
        for _, ch := range s {
            freq[ch]++
        }
        uniqueCount := 0
        for _, v := range freq {
            if v == 1 {
                uniqueCount++
            }
        }
        if uniqueCount > 0 && uniqueCount%2 == 0 {
            count++
        }
    }
    return count
}