func similarPairs(words []string) int {
    count := 0
    n := len(words)
    for i := 0; i < n; i++ {
        setI := make(map[rune]bool)
        for _, c := range words[i] {
            setI[c] = true
        }
        for j := i + 1; j < n; j++ {
            setJ := make(map[rune]bool)
            for _, c := range words[j] {
                setJ[c] = true
            }
            if len(setI) != len(setJ) {
                continue
            }
            match := true
            for k := range setI {
                if !setJ[k] {
                    match = false
                    break
                }
            }
            if match {
                count++
            }
        }
    }
    return count
}