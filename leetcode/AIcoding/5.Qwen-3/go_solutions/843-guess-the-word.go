package main

func findSecretWord(wordlist []string, master *Master) {
    for i := 0; i < 10; i++ {
        guess := wordlist[0]
        match := master.guess(guess)
        if match == 0 {
            for j := 0; j < len(wordlist); j++ {
                if similar(guess, wordlist[j]) {
                    wordlist = append(wordlist[:j], wordlist[j+1:]...)
                    j--
                }
            }
        } else {
            for j := 0; j < len(wordlist); j++ {
                if !similar(guess, wordlist[j]) {
                    wordlist = append(wordlist[:j], wordlist[j+1:]...)
                    j--
                }
            }
        }
    }
}

func similar(a, b string) bool {
    count := 0
    for i := 0; i < len(a); i++ {
        if a[i] == b[i] {
            count++
        }
    }
    return count > 0
}

type Master struct {
    func guess(string) int
}