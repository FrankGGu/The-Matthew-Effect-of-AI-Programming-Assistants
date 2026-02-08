func percentageLetter(s string, letter byte) int {
    count := 0
    for i := 0; i < len(s); i++ {
        if s[i] == letter {
            count++
        }
    }

    if len(s) == 0 {
        return 0
    }

    return (count * 100) / len(s)
}