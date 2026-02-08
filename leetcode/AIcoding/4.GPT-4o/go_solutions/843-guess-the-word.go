type Master struct {
    words []string
}

func (m *Master) Guess(word string) int {
    // Implementation of Guess method is handled by LeetCode platform.
    return 0
}

func findSecretWord(guess []string, master Master) {
    for i := 0; i < 10; i++ {
        for _, w := range guess {
            if master.Guess(w) == 6 {
                return
            }
        }
    }
}