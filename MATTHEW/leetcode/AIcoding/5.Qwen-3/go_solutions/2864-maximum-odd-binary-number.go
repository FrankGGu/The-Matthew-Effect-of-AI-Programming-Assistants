package main

func maximumOddBinaryNumber(s string) string {
    count := 0
    for _, c := range s {
        if c == '1' {
            count++
        }
    }
    return "1" + strings.Repeat("0", len(s)-count-1) + strings.Repeat("1", count-1)
}