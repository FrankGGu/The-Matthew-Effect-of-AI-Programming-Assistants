func maxRepeating(sequence string, word string) int {
    max := 0
    n := len(word)
    for i := 0; i <= len(sequence)-n; i++ {
        if sequence[i:i+n] == word {
            count := 1
            for j := i + n; j <= len(sequence)-n; j += n {
                if sequence[j:j+n] == word {
                    count++
                } else {
                    break
                }
            }
            if count > max {
                max = count
            }
        }
    }
    return max
}