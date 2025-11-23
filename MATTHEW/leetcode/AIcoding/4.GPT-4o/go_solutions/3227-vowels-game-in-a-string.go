func vowelsGame(s string) string {
    vowels := "aeiou"
    player1, player2 := 0, 0
    for _, ch := range s {
        if strings.ContainsRune(vowels, ch) {
            player1++
        } else {
            player2++
        }
    }
    if player1 > player2 {
        return "Kevin"
    } else if player2 > player1 {
        return "Bob"
    }
    return "Draw"
}