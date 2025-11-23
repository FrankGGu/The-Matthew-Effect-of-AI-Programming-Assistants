func game(guess []int, wish []int) int {
    count := 0
    for i := 0; i < len(guess); i++ {
        if guess[i] == wish[i] {
            count++
        }
    }
    return count
}